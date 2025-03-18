public with sharing class AccountController {

    @AuraEnabled(cacheable=true)    // with wire we can invoke method
    public static List<Account> getAccounts()
    {
        System.debug('get Accounts method called');
       // return [select Id,Name,Type,Phone,Industry from Account WITH SECURITY_ENFORCED limit 10];
        return [select Id,Name, RichText_Description__c,Description from Account where Id='001J100000OsPTKIA3' WITH SECURITY_ENFORCED];
    }
    
    @AuraEnabled // without wire we can invoke method
    public static List<Account> getAccountRecordList()
    {
        System.debug('imperatively this method called');
        return [select id,name,type,phone,industry from account WITH SECURITY_ENFORCED limit 10 ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList()
    {
        try 
        {
            System.debug('getAccountList method called');
            return [select Id,Name,Phone, Rating,Industry,Type from Account  where Industry != null and Type != null WITH SECURITY_ENFORCED];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}