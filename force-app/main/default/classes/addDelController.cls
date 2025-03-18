public with sharing class addDelController 
{
    @AuraEnabled
    public static void insertContacts(List<Contact> contList)
    {
        try {
            System.debug('contList: ' + contList);
            insert as user contList;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
}