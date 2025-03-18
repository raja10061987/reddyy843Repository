public with sharing class QuickContactCreation 
{
    @AuraEnabled
    public static String createContactWithAccountDetails(String accountId)
    {
        System.debug('accountId: ' + accountId);
        Account actObj = [select Id,Name,Phone from Account where Id=:accountId WITH SECURITY_ENFORCED];
        System.debug('actObj: ' + actObj); // Account: {Id=001jdhsdj,Name=pavan,Phone=23745237}
        Contact conObj = new Contact();
        conObj.LastName = actObj.Name;
        conObj.Phone = actObj.Phone;
        conObj.AccountId = actObj.Id;
        insert as user conObj;
        System.debug('conObj: ' + conObj); // Conatct: {LastName=pavan,Phone=23745237,AccountId=001jdb}
        return conObj.Id;
 
    }

    @AuraEnabled
   public static String createContact(Contact conObj)
   {
    System.debug('conObj: ' + conObj); // Contact:{FirstName=suman,LastName=reddy,Phone=12333}
    insert as user conObj;
    return conObj.Id;

   }    
}