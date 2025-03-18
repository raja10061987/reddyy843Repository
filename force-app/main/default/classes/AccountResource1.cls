@RestResource(urlMapping= '/AccountAPI1/*')
global with sharing class AccountResource1 
{
   @HttpGet
  global static List<Account> getmyAccounts()
  {
      RestRequest accountContext = RestContext.request;
      map<string,string> contactParams = accountContext.params;
      system.debug('accountContext: ' + accountContext);
      system.debug('contactParams: ' + contactParams);
      string Rating = contactParams.get('rating');
      integer contactLimit = Integer.valueOf(contactParams.get('limit'));
      system.debug('Rating: ' + Rating);
      system.debug('contactLimit: ' + contactLimit);
      List<Account> acctList = [select id,name,phone,Rating from account where rating=:Rating limit:contactLimit];
      system.debug('acctList: ' + acctList);
      return acctList;
      
  }
}