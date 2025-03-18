public with sharing class saveRecord {
    public List<Account> actList{get;set;}
    public saveRecord(RetriveAccounts customcontroller) {
        actList = new List<Account>();
       actList = [select id,name,type,rating,Budget__c,SLA__c from account limit 10];
    }
}