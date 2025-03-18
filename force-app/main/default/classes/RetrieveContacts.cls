public with sharing class RetrieveContacts 
{
    public List<Contact> contList {get;set;}
    public RetrieveContacts() 
    {
        contList = new List<Contact>();
        contList = [select Id,FirstName, LastName, Phone, Email, AccountId,LeadSource from Contact  where FirstName != null WITH SECURITY_ENFORCED];
        System.debug('contList size: ' + contList.size());


    }
}