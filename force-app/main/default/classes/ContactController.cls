public with sharing class ContactController {
    
    @AuraEnabled
    public static string insertContact(Contact conObj)
    { // Contact: {firstName=rahja,LastName= pavan,Phone=35353}
        System.debug('conObj@@@: ' + conObj);
        system.debug('First Name: ' + conObj.FirstName);
        System.debug('Last Name: ' + conObj.LastName);
        try {
            insert as user  conObj;
            return conObj.Id;
            
        } catch (Exception e) 
        {
            System.debug('error message: ' + e);
            throw new AuraHandledException(e.getMessage());
        }
    }


    @AuraEnabled
    public static List<Contact> retriveContacts(){
        try {
            List<Contact> contList = [select id,FirstName, LastName, Phone,email from Contact];
            return contList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}