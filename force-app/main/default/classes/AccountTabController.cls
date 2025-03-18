public with sharing class AccountTabController 
{
    public List<Account> actList {get;set;}
    public String currentAccountName {get;set;}
    public String currentAccountId {get;set;}
    public String contactName {get;set;}
    public String contactId {get;set;}
    public String caseId {get;set;}
    public String caseNumber {get;set;}
    public AccountTabController() 
    {
        actList = [select Id,Name,Type,Phone,Rating,Industry from Account where Industry != null WITH SECURITY_ENFORCED];
        System.debug('actList size: ' + actList.size());

    }

    public pageReference retriveLatestRecords()
    {
        List<Contact> contList = new List<Contact>();
        List<Case> caseList = new List<Case>();
        System.debug('currentAccountId: ' + currentAccountId);
        System.debug('currentAccountName: ' + currentAccountName);
        if(currentAccountId != null)
        {
            contList = [select Id,Name,AccountId from Contact where AccountId =:currentAccountId WITH SECURITY_ENFORCED order by LastModifiedDate desc limit 1];
            caseList = [select Id,CaseNumber,AccountId from case where AccountId =:currentAccountId WITH SECURITY_ENFORCED order by LastModifiedDate  desc limit 1];
            System.debug('contList: ' + contList);
            System.debug('caseList: ' + caseList);
        }
        if(contList.size() > 0)
        {
            contactName = contList[0].Name;
            contactId = contList[0].Id;
        }
        if(caseList.size() > 0)
        {
            CaseNumber = caseList[0].caseNumber;
            caseId = caseList[0].Id;

        }
        System.debug('contactName: ' + contactName + ' contactId ' + contactId + ' CaseNumber ' + CaseNumber + 'caseId ' + caseId);

        return null;
    }
}