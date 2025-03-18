public with sharing class AccountSearchController 
{

    @AuraEnabled(cacheable = true)
    public static List<Account> searchAccounts(string actName)
    {
        try 
        {
            String searchString;
            System.debug('searchString: ' + actName);
            if(actName != null)
            {
                 searchString = '%'+ actName + '%';
            }
            else {
                searchString = '%';
            }
            
           
            List<Account> actList = [select id,Name,Phone, Rating from Account where Name like:searchString WITH SECURITY_ENFORCED];
            System.debug('actList: ' + actList); // (Account:{Id=001snanc,Name=raja},Account:{Id=001xmnc,name=pavan})
            return actList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(string actName){
        try 
        {
            String searchString;
            List<Account> actList = new List<Account>();
            System.debug('actName: ' + actName);
           if(actName != null)
           {
            System.debug('inside if block');
             searchString =  '%' + actName + '%';
             System.debug('searchString: ' + searchString);
             actList = [select Id,Name,Phone,Rating,Industry from Account where Name like:searchString WITH SECURITY_ENFORCED];
            
           }
           return actList; // (), (Account: {Name=test1,Phone=123,Id=001bxcb},Account: {Name= test2,Phone=122,Id=001dajxn})
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}