public with sharing class AccountRecordsController 
{
    @AuraEnabled
    public static List<Account> getRecords()
    {
        return [Select Id,Name,Industry from Account WITH SECURITY_ENFORCED Limit 10];

    }
    
    @AuraEnabled
    public static List<Account> getAccountRecords(string objectName,string fields)
    {
        System.debug('objectName: ' + objectName + 'fields: ' + fields);
        return Database.query('select Id,'+String.escapeSingleQuotes(fields)+' from '+String.escapeSingleQuotes(objectName)+'');
    }
}