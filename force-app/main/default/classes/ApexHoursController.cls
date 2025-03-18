public with sharing class ApexHoursController 
{
    @AuraEnabled
    public static List<Contact> getContacts(String recordId)
    {
        List<Contact> contactList = [select Id,Name,Phone,Email from Contact where AccountId=:recordId WITH SECURITY_ENFORCED];
        System.debug('contactList: ' + contactList);
        return contactList;
    }
    
}