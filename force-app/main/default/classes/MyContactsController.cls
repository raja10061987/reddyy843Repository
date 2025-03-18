public with sharing class MyContactsController 
{
    @AuraEnabled
    public static List<Contact> getContacts(List<Id> acctIds)
    {
       //  system.debug('acctIds: ' + acctIds);
        List<Contact> contLIst = [select phone,Email,FirstName, LastName,Name,AccountId,MobilePhone from Contact where Accountid in:acctIds WITH SECURITY_ENFORCED];
        // system.debug('contLIst: ' + contLIst);
        return contLIst;
        
    }

    @AuraEnabled
    public static Map<string,string> saveContatcts(List<Contact> contList)
    {
        Map<String,String> resultMap = new Map<String,String>();
        try {
            update contList;
            resultMap.put('status', 'success');
            resultMap.put('message', 'data saved successfully');

        } catch (Exception e) {
           resultMap.put('status', 'error');
           resultMap.put('message', e.getMessage());
        }
        return resultMap;
    }


    @AuraEnabled
    public static Map<string,string> removeContacts(List<Id> contactidsList)
    {
        System.debug('contactidsList: ' + contactidsList);
        Map<String,String> resultMap = new Map<String,String>();
        try {
            List<Contact> contactsTobeDelete = [select id from Contact where id in:contactidsList];
            System.debug('contactsTobeDelete@@: ' + contactsTobeDelete);
            delete contactsTobeDelete;
           
            resultMap.put('status', 'success');
            resultMap.put('message', 'contact record deleted successfully');
            System.debug('resultMap: ' + resultMap);
            
        } catch (Exception e) {
            resultMap.put('status', 'error');
            resultMap.put('message', e.getMessage());
            System.debug('error ocuured: ' + e.getMessage());
        }
        return resultMap;
    }


    @AuraEnabled
    public static Map<String,String> createContact(Contact conObj)
    {
        Map<String,String> resultMap = new Map<String,String>();
        try {
            insert as user conObj;
            resultMap.put('status', 'success');
            resultMap.put('message', 'contact created successfully');
            System.debug('resultMap: ' + resultMap);
            
        } catch (Exception e) {
            resultMap.put('status', 'error');
            resultMap.put('message', e.getMessage()); // {message= error occured,status=error}
        }
        return resultMap;
    }

}