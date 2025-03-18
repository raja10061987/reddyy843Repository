public with sharing class ApexUtil 
{
    public ApexUtil() {

    }
   
   public static Map<String,String> getObjectAPINameToLabel()
   {
    Map<String,String> GlobalObjectAPINamesLbels = new Map<String,String>();
   Map<String,Schema.SObjectType> getAllSObjetsMap = Schema.getGlobalDescribe();
   System.debug('getAllSObjets: ' + getAllSObjetsMap);

   for (String sObjectKey : getAllSObjetsMap.keySet()) 
   {
   Schema.SObjectType currentSobjectType =  getAllSObjetsMap.get(sObjectKey);
  Schema.DescribeSObjectResult currentSobjectResult = currentSobjectType.getDescribe();
  GlobalObjectAPINamesLbels.put(currentSobjectResult.getName(), currentSobjectResult.getLabel());
   }
    system.debug('GlobalObjectAPINamesLbels: ' + GlobalObjectAPINamesLbels);
   return GlobalObjectAPINamesLbels;

   }

   public static set<string> getsObjectFields(string objectAPIName)
   {
      set<String> fieldsResultSet = new Set<String>();
     Map<String,Schema.SObjectType> getAllSObjects = Schema.getGlobalDescribe();
     System.debug('getAllSObjects: ' + getAllSObjects);
    Schema.SObjectType currentSObjectType = getAllSObjects.get(objectAPIName);
    System.debug('currentSObjectType: ' + currentSObjectType);
    if (currentSObjectType != null)
    {
      Map<String,Schema.SObjectField> fieldsMap = currentSObjectType.getDescribe().fields.getMap();
      System.debug('fieldsMap: ' + fieldsMap);
      for (Schema.SObjectField eachField : fieldsMap.values()) {
         System.debug('eachField: ' + eachField);
       Schema.DescribeFieldResult eachFieldResult =  eachField.getDescribe();
       System.debug('eachFieldResult: ' + eachFieldResult);
       if (eachFieldResult.isAccessible())
       {
        System.debug('getName: ' + eachFieldResult.getName());
        fieldsResultSet.add(eachFieldResult.getName());
   
       }
       
      }

    }

   System.debug('fieldsResultSet: ' + fieldsResultSet);
   return fieldsResultSet;
   }



   public static String getSOQL(string obJectAPIName)
   {
      set<String> objectFields = getsObjectFields(obJectAPIName);
      System.debug('objectFields: ' + objectFields);
      String query = ' select ';
      for (String field : objectFields) 
      {
         query+= field + ',';
         // select id,name,email,phone,
      }
      query = query.substring(0, query.lastIndexOf(','));
      // select id,name,email,phone
      query += ' from ' + obJectAPIName;
      System.debug('my soqlquery: ' + query);
    
      return query;

   }


   public static void getPickListValuesMap(String objectAPIName,String fieldAPIName)
   {
      Map<String,String> pickListFieldsMap = new Map<String,String>();
       // get the field info
       Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe().get(objectAPIName)?.getDescribe()?.fields.getMap()?.get(fieldAPIName)?.getDescribe();
       System.debug('fieldResult: ' + fieldResult);
       System.debug('fieldResult Type: ' + fieldResult?.getType());
       

       if (fieldResult?.getType() == Schema.DisplayType.PICKLIST)
       {
        
         List<Schema.PicklistEntry> pickListEntryies = fieldResult.getPicklistValues();
         System.debug('pickListEntryies: ' + fieldResult.getPicklistValues());

         for (Schema.PicklistEntry pickListEntry : pickListEntryies) 
         {
           System.debug('each PickList Entry: ' + pickListEntry);
           if (pickListEntry.isActive())
           { 
           String pickListLabel = pickListEntry.getLabel();
           String pickListValue = pickListEntry.getValue();
           pickListFieldsMap.put(pickListLabel, pickListValue);

           }   
         }
         System.debug('pickListFieldsMap: ' + pickListFieldsMap);

         for (string labelName : pickListFieldsMap.keySet()) {
             // System.debug('each label Name: ' + labelName);
             System.debug('label Name: ' + labelName + ' <===> API Name: ' + pickListFieldsMap.get(labelName));
         }
       }
      
   }

   
   public static map<string,id> getRecordidByName(string objetctAPIName)
   {
      Map<String,Id> recordTypeMap = new Map<String,Id>();
    Schema.DescribeSObjectResult currentObjectResult =  Schema.getGlobalDescribe().get(objetctAPIName)?.getDescribe();
    System.debug('currentObjectResult: ' + currentObjectResult);
    if(currentObjectResult != null)
    {
          List<Schema.RecordTypeInfo> recordTypeInfos =  currentObjectResult.getRecordTypeInfos();
          System.debug('recordTypeInfos: ' + recordTypeInfos);

          for (Schema.RecordTypeInfo recordType : recordTypeInfos) {
            System.debug('each RecordType: ' + recordType);
            if(recordType.isActive() && recordType.isAvailable())
            {
              recordTypeMap.put(recordType.getDeveloperName(), recordType.getRecordTypeId());
            }
            
          }
    }
    System.debug('recordTypeMap: ' + recordTypeMap);
    return recordTypeMap;
   }

   public static string getRecords(String inputData)
   {
    System.debug('inputData: ' + inputData); // {"name": "account","searchText": "raja"}
    Map<String,Object> inputDataMap =new Map<String,Object>();
     inputDataMap = (Map<String,Object>)JSON.deserializeUntyped(inputData);
    // System.debug('inputObject: ' + inputObject); // {name=account, searchText=raja}
    System.debug('inputDataMap: ' + inputDataMap); // {name=account, searchText=raja}
   string ObjectName = (String)inputDataMap.get('name'); // account
   String searchText = (String)inputDataMap.get('searchText'); // raja
   System.debug('ObjectName: ' + ObjectName + '<==>' + 'searchText: ' + searchText);
   Schema.SObjectType currentObjectType =  Schema.getGlobalDescribe().get(ObjectName);
  System.debug('currentObjectType: ' + currentObjectType);  // Account
  Map<String,Schema.SObjectField> fieldMap = currentObjectType?.getDescribe()?.fields?.getMap(); // {accountnumber=AccountNumber, accountsource=AccountSource}
  System.debug('fieldMap: ' + fieldMap);
  String searchQuery= '';
  if(fieldMap != null && fieldMap.get('name') != null)
  {
   System.debug('inside if block');
  // seacrhQuery = 'FIND {'+ searchText +'} IN ALL FIELDS RETURNING ' + ObjectName + '{name}';
  searchQuery = 'FIND {'+searchText+'} IN ALL FIELDS RETURNING '+ObjectName;  
   System.debug('seacrhQuery: ' + searchQuery);

  }

  List<List<SObject>> searchList = search.query(searchQuery);
  System.debug('searchList: ' + searchList);
  System.debug('searchLit Size: ' + searchList.size());
  if(searchList.size() == 1)
  {
    return JSON.serialize(searchList.get(0));
  }
  return '';

   }


   public static void searchRecords()
   {

    LIST<LIST<SObject>> lstResults = [ FIND 'test*' IN ALL FIELDS RETURNING
                                       ACCOUNT(Id,name,rating,industry,phone),
                                       LEAD (LeadSource,Name,Status),
                                       CONTACT(id,firstname,lastName,phone,fax)
    ];
    System.debug('lstResults size: ' + lstResults.size());


    if(!lstResults.isEmpty())
    {
     List<Account> actResult = (List<Account>)lstResults.get(0);
     List<Lead> leadResult = (List<Lead>)lstResults.get(1);
    List<sObject> contResult = lstResults.get(2);
     System.debug('leadResult:size ' + leadResult.size());
     System.debug('actResult: size ' + actResult.size());
     System.debug('contResult: size ' + contResult.size());

     for(Account actObj: actResult)
     {
        
        System.debug('actObj: ' + actObj);
     }

     for (Lead leadObj : leadResult) 
     {

      System.debug('each lead record: ' + leadObj);
     }

     for (sObject conObj : contResult) {
      system.debug('each contact Record: ' + conObj);
     }
      
    }
    
   }

   public static void dynamicSearchByText(string searchText)
   {
    string searchQuery = 'FIND '+ '\'' + searchText + '*'+ '\''+ ' IN ALL FIELDS RETURNING '+
                                      'Account (Id, name, rating, industry, type, active__C),' +
                                      'Lead(id, firstname, lastname, email, company, title, status),'+
                                       'User(id, firstname, lastname, title, email, username, isactive),'+
                                       'Candidate__c(id, name, location__C, notice_period__C),'+
                                       'Position__C(id, name, location__C, position_status__c)';


    System.debug('searchQuery: ' + searchQuery);                                   
     
     if(searchQuery != null)
     {
      List<List<sObject>> searchResults =  search.query(searchQuery);
      System.debug('searchResults size: ' + searchResults);
      System.debug('searchResults: ' + searchResults.size());
       if(!searchResults.isEmpty())
       {
       List<Account> actList =  (List<Account>)searchResults.get(0);
       List<Lead> leadList  = (List<Lead>)searchResults.get(1);
       System.debug('actList size:' + actList.size());
       System.debug('actList:' + actList);
       System.debug('leadList size: ' + leadList.size());
       System.debug('leadList: ' + leadList);

       for (Account act : actList) {
        System.debug('each account: ' + act);
       }

       for (Lead lead : leadList) {
        System.debug('each lead record: ' + lead);
       }

       }

     }

   }

   public static String getSearchRecords(string inputData)
   {
   Map<String,Object> myInputData = (Map<String,Object>)JSON.deserializeUntyped(inputData);
   System.debug('myInputData: ' + myInputData); // {name=Account, searchText=test}
   String sObjectName = (String)myInputData.get('name');
  String searchText =  (String)myInputData.get('searchText');
  System.debug('sObjectName ' + sObjectName + ' seachText ' + searchText);
     Schema.SObjectType currentSobjectType = Schema.getGlobalDescribe().get(sObjectName);
  System.debug('currentSobjectType: ' + currentSobjectType);
 Map<String,Schema.SObjectField> currentObjectFieldResult = currentSobjectType?.getDescribe()?.fields?.getmap();
 System.debug('currentObjectResult: ' + currentObjectFieldResult);
 System.debug('current Object Field Result name: ' + currentObjectFieldResult?.get('name'));
    String seacrhQuery = '';
 if (currentObjectFieldResult != null && currentObjectFieldResult.get('name') != null)
 {
  System.debug('entered inside if block');
  seacrhQuery = 'FIND {'+searchText+'} IN ALL FIELDS RETURNING ' +  sObjectName + '(Name,rating,Phone)';
  System.debug('inside if block');
  System.debug('seacrhQuery: ' + seacrhQuery);
 }
 else {
  seacrhQuery = 'FIND {'+searchText+'} IN ALL FIELDS RETURNING ' + sObjectName;
   System.debug('inside else block: ' + seacrhQuery);
 }
  List<List<Sobject>> searchResults = Search.query(seacrhQuery);
  System.debug('searchResults: ' + searchResults);
  System.debug('searchResults size: ' + searchResults.size());

  if (searchResults.size() == 1)
  {
   List<SObject> actList =  searchResults.get(0);
  String jsonReturnString = JSON.serialize(actList);
  System.debug('jsonReturnString: ' + jsonReturnString);
  return jsonReturnString;
  }

  return '';










   }


}