public with sharing class FetchAccountRecords 
{
     public List<Account> actList {get;set;}
    public FetchAccountRecords(ApexPages.StandardController controller) {
         actList = new List<Account>();
        actList = [select Id,Name,Phone,Rating,Budget__c from Account limit 10];
    }
}