public  class getAllAccounts 
{
    public List<account> actList {get;set;}
    public getAllAccounts()
    {
        actList = new List<Account>();
        actList = [select id,name,rating,phone,AnnualRevenue,active__c from account where active__c = 'NO'];
        system.debug('actList:' + actList);
    }

}