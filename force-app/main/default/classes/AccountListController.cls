public with sharing class AccountListController 
{
    @AuraEnabled
    public static List<Account> fetchActs(){
        try {
            return [select id,name,Industry, type from account WITH SECURITY_ENFORCED];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}