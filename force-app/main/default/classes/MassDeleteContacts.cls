public with sharing class MassDeleteContacts 
{

    @AuraEnabled(cacheable = true)
    public static List<Contact> retriveContacts(){
        try {
            List<Contact> contList = [select Id,FirstName, LastName, Phone, email,CreatedDate from Contact where FirstName != null WITH SECURITY_ENFORCED order by CreatedDate desc ];
            System.debug('contList: ' + contList); // (Contact:{Id=003msxabs,FirstName=raja},Contact: {Id=003jsbxa,LastName=suman})
            return contList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Contact> deleteContacts(List<Id> contactIds)
    {
        System.debug('contactIds: ' + contactIds);
        List<Contact> contList = new List<Contact>();
        List<Contact> finalContacts = new List<Contact>();
        try {
            contList = [select Id,FirstName, LastName, Phone, Email from contact where id in:contactIds  WITH SECURITY_ENFORCED];
            System.debug('contList to be delete: ' + contList);
            delete as user contList;
            finalContacts = [select Id,FirstName, LastName, Phone, Email from contact where FirstName != null  WITH SECURITY_ENFORCED];
            system.debug('finalContacts length: ' + finalContacts.size());
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return finalContacts;
    }
    
}