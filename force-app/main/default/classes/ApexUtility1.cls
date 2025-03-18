public with sharing class ApexUtility1 
{

    public static Map<String,String> getObjectAPINameLabelName()
    {
        Map<String,String> objectApiLabelApiMap = new Map<String,String>();
        Map<String,Schema.sObjectType> allObjectsMap = Schema.getGlobalDescribe();
        for(String sObjectKey : allObjectsMap.keyset())
        {
            Schema.DescribeSObjectResult currentSObjectDes = allObjectsMap.get(sObjectKey).getDescribe();
            System.debug('currentSObjectDes: ' + currentSObjectDes);
            if(currentSObjectDes.isAccessible())
            {
                objectApiLabelApiMap.put(currentSObjectDes.getName(),currentSObjectDes.getLabel());
            }
    
        }
        return objectApiLabelApiMap;
    }

    public static List<String> getFieldsOfSObject(String objectName)
    {
        List<String> fieldsList = new List<String>();
        Map<String,Schema.sObjectField> fieldMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        System.debug('fieldMap: ' + fieldMap);
        for(Schema.sObjectField eachField : fieldMap.values())
        {
            Schema.DescribeFieldResult fieldDescribe = eachField.getDescribe();
            System.debug('fieldDescribe: ' + fieldDescribe);
            if(fieldDescribe.isAccessible())
            {
                fieldsList.add(fieldDescribe.getName());
            }
        }
        return fieldsList;
    }

    public static string getDynmicSOQL()
    {
        List<String> fieldsList = getFieldsOfSObject('Account');
        string soql = 'select ';
        for(String eachField : fieldsList)
        {
            soql += eachField + ',';
        }
        soql = soql.substring(0, soql.length() - 1);
        soql+=  ' from Account';
        return soql;
       

    }

    public static Map<String,String> getPickListValee(string objectApiName,string fieldApiName)
    {
        Map<String,String> pickListValuesMap = new Map<String,String>();
        Schema.DescribeFieldResult fieldDescribe = Schema.getGlobalDescribe().get(objectApiName)?.getDescribe().fields.getMap().get(fieldApiName)?.getDescribe();
        System.debug('fieldDescribe: ' + fieldDescribe);
        List<Schema.PicklistEntry> pickListValues = fieldDescribe.getPicklistValues();
        System.debug('pickListValues: ' + pickListValues);
        for (Schema.PicklistEntry eachPickList : pickListValues) {
            System.debug('eachPickList: ' + eachPickList);
            if(eachPickList.isActive())
            {
                 pickListValuesMap.put(eachPickList.getLabel(), eachPickList.getValue());
            }
        }
        
        return pickListValuesMap;


    }

    public static Map<String,Id> getRecordTypeIdByName(string objectName)
    {
        Map<String,Id> recordTypeLablevsIdMap = new Map<String,Id>();

        Schema.DescribeSObjectResult sObjectResult = Schema.GetGlobalDescribe().get(objectName).getDescribe();
        System.debug('sObjectResult: ' + sObjectResult);
        List<Schema.RecordTypeInfo> recordTypeInfosList = sObjectResult.getRecordTypeInfos();
        for(Schema.RecordTypeInfo eachRecordTypeInfo : recordTypeInfosList)
        {
            System.debug('eachRecordTypeInfo: ' + eachRecordTypeInfo);
            if(eachRecordTypeInfo.isActive())
            {
                recordTypeLablevsIdMap.put(eachRecordTypeInfo.getName(), eachRecordTypeInfo.getRecordTypeId());
            }
        }
            
        
        return recordTypeLablevsIdMap;

    }

    public static void searchText()
    {

        List<List<sObject>> recordsList = [find 'test*' IN ALL FIELDS Returning
                                           Student__C(Id,Name),
                                           Account(Id,Name,Phone,Rating)
                                         ];
        System.debug('recordsList: ' + recordsList);
        List<Student__C> studentList = (List<Student__C>)recordsList.get(0);
        System.debug('studentList size: ' + studentList.size());
        List<Account> actsList = (List<Account>)recordsList.get(1);
        System.debug('actsList size: ' + actsList.size());
        for(Student__C stdObj:studentList)
        {
            System.debug('student Record: ' + stdObj);
        }
        for (Account actObj : actsList) 
        {
        System.debug('account record: ' + actObj);    
        }

    }

    public static void dynamicSearchText(string searchText)
    {
        string searchQuery = 'FIND '+ '\'' + searchText + '*'+ '\''+ ' IN ALL FIELDS RETURNING '+
                              'Student__C (Id,Name,Email__C),' +
                              'Account(id,Name,Rating,Industry)';
            List<List<sObject>> recordsList = search.Query(searchQuery);
            System.debug('recordsList: ' + recordsList);

              List<Student__c> studentList = (List<Student__C>)recordsList[0];
              List<Account> actsList = (List<Account>)recordsList[1];
              System.debug('studentList size: ' + studentList.size());
              System.debug('actsList size: ' + actsList.size());
              for (Student__C studentObj : studentList) 
              {
                System.debug('student record: ' + studentObj);
                
              }
              for(Account actObj: actsList)
              {
                System.debug('account record: ' + actObj);
              }
                            


    }


   
}