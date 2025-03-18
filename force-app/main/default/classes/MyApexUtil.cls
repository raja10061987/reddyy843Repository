public with sharing class MyApexUtil {
    public MyApexUtil() {

    }

    public static Map<String,String> getObjectAPINametoLabel()
    {
        Map<String,String> mapObjectAPINameLabel = new Map<String,String>();

       Map<String,Schema.SObjectType> allObjects = Schema.getGlobalDescribe();
       // {Account = account}

       for (string currentObjectKey : allObjects.keySet()) 
       {

        Schema.SObjectType currentObjectType = allObjects.get(currentObjectKey);
        Schema.DescribeSObjectResult currentObjectResult = currentObjectType.getDescribe();
        if(currentObjectResult.accessible)
        {
         mapObjectAPINameLabel.put(currentObjectResult.getName(), currentObjectResult.getLabel());
        }
        
       }
       System.debug('mapObjectAPINameLabel: ' + mapObjectAPINameLabel);

       for (string objectAPIName : mapObjectAPINameLabel.keySet()) {
        System.debug(objectAPIName + ' label name: ' + mapObjectAPINameLabel.get(objectAPIName));
       }

       return mapObjectAPINameLabel;
    }

    public static set<String> getsObjectFields(string sobjectAPIName)
    {
        Set<String> objectAPIFields = new Set<String>();

        map<String,Schema.SObjectType> globalSobjects = Schema.getGlobalDescribe();
      
        // Account = account
       Schema.SObjectType currentsObjectType = globalSobjects.get(sobjectAPIName); // Account
       if(currentsObjectType != null)
        {
        Map<String,Schema.SObjectField> fieldsMap =  currentsObjectType.getDescribe().fields.getMap();
        // {id=id,rating=rating}
        for(Schema.SObjectField fieldAPIName:fieldsMap.values())
      {
       Schema.DescribeFieldResult eachFieldResult = fieldAPIName.getDescribe();
       if(eachFieldResult.accessible)
       {
        objectAPIFields.add(eachFieldResult.getName());
       }
      }
     }

     
     return objectAPIFields;

    }

    public static string getSOQL(string objectAPIName)
    {
     Set<String> fieldsList = getsObjectFields(objectAPIName);

     // form SOQL query

    // string query = 'select name,phone,rating from account';
    string query = 'select ';
    for(String eachField:fieldsList)
    {
     query += eachField + ',';
    }
   if (query.contains(','))
   {
    query = query.substring(0, query.lastIndexOf(','));
    query += ' from ' + objectAPIName;
   }
    
  return query;

    }


public static Map<String,String> getpickListValuesmap(string objectAPIName,String fieldAPIName)
{

    Map<String,String> pickListFieldsMap = new Map<String,String>();
    // get the field Description

 Schema.DescribeFieldResult fieldResult =  Schema.getGlobalDescribe().get(objectAPIName)?.getDescribe()?.fields?.getMap()?.get(fieldAPIName).getDescribe();
 System.debug('fieldResult: ' + fieldResult);
 System.debug('fieldResult getType: ' + fieldResult.getType());
 System.debug('@@@@: ' + Schema.DisplayType.PICKLIST);

 if (fieldResult.getType() == Schema.DisplayType.PICKLIST) // PICKLIST
 {
    List<Schema.PicklistEntry> pickListValues = fieldResult.getPicklistValues();

    for(Schema.PicklistEntry pickListValue:pickListValues)
    {
        System.debug('pickListValue: ' + pickListValue);
        if (pickListValue.isActive())
        {
            string fieldlabelName = pickListValue.getLabel();
            String fieldName = pickListValue.getValue();
            pickListFieldsMap.put(fieldlabelName, fieldName);

        }

    }

    return pickListFieldsMap;

 }
 return pickListFieldsMap;


}

public static Map<String,Id> getRecordTypeIdByName(String objectAPIName)
{
    Map<String,Id> mapRecordTypeNameId = new Map<String,Id>();

  Schema.DescribeSObjectResult cureentObjectResult =  Schema.getGlobalDescribe().get(objectAPIName)?.getDescribe();
  if(cureentObjectResult != null)
  {
    System.debug('cureentObjectResult: ' + cureentObjectResult);
   List<Schema.RecordTypeInfo> recordTypeInfos = cureentObjectResult.getRecordTypeInfos();
   System.debug('recordTypeInfos: ' + recordTypeInfos);

   for(Schema.RecordTypeInfo recordTypeInfo:recordTypeInfos)
   {
        if(recordTypeInfo.isActive() && recordTypeInfo.isAvailable())
        { 
         mapRecordTypeNameId.put(recordTypeInfo.getDeveloperName(), recordTypeInfo.getRecordTypeId());
        }
   }
   
  }
  return mapRecordTypeNameId;

}


public static string searchRecords(string inputData)
{
    Map<string,Object> inputSearchData = new Map<String,Object>();
    System.debug('inputdata: ' + inputData);
    //  {"ObjectAPIName": "Account", "searchText": "test"}
    inputSearchData = (Map<String,Object>)JSON.deserializeUntyped(inputData); // {ObjectAPIName = Account,searchText = test}
    system.debug('inputSearchData: ' + inputSearchData);
    string objectAPIName = (String)inputSearchData.get('ObjectAPIName');
    string searchText = (String)inputSearchData.get('searchText');
    System.debug('objectAPIName: ' + objectAPIName); // Account
    System.debug('seacrchText: ' + searchText); // Test
    String searchQuery = '';
    if (objectAPIName != null && searchText != null)
    {
        searchQuery = 'FIND {'+searchText+'} IN ALL FIELDS RETURNING ' + objectAPIName + '(name,Rating,Active__c)';
    }
    System.debug('searchQuery: ' + searchQuery);

   List<List<sObject>> searchResults = Search.query(searchQuery);
   System.debug('searchResults size: ' + searchResults.size());
   System.debug('searchResults: ' + searchResults.get(0));
   if (searchResults.size() == 1)
   { 
  String  returnedResults = JSON.serialize(searchResults.get(0));
  return returnedResults;
   }
   return '';

}








}