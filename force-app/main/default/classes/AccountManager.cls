@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
        global static Account getAccount() {
        RestRequest request = RestContext.request;
            
       string accountId = request.requestURI.substringBetween('Accounts/','/contacts');
        system.debug('accountid' + accountId);
        Account result = [select Id,Name,(select Id,Name from contacts) from Account where Id =:accountId];
        
        return result;
    }
    
       
}