public with sharing class ShowAccounts 
{
    public List<Account> accountList {get;set;}
    public String accountId {get;set;}
    public Account actRecord {get;set;}
    public ShowAccounts() 
    {
       // actRecord = new Account();
      //  accountList = new List<Account>();
        accountList = [select Id,Name, Phone,Rating, Industry from Account WITH SECURITY_ENFORCED Limit 5];
        System.debug('accountList size: ' + accountList.size());

    }

    public void retriveAccounts()
    {
        System.debug('accountId: ' + accountId);
         if(accountId != null)
          {
           actRecord = [select Id,Name,Rating,Phone,industry from Account where Id=:accountId WITH SECURITY_ENFORCED];
           System.debug('actRecord: ' + actRecord);
           // return actRecord;
          }
        // return actRecord;
    }
}