public with sharing class ActionRegionController 
{
    public String actName {get;set;}
    public Account actObj {get;set;}
    public ActionRegionController() 
    {
        actObj = new Account();

    }

    public pageReference getAccountByName()
    {
        try {
            actObj = [select Id,name,Phone,Rating,Description,AccountNumber from Account where Name=: actName limit 1];
            System.debug('actObj: ' + actObj);
        } catch (Exception e) {
            System.debug('error occured: ' + e);
        }
        
        return null;
    }
}