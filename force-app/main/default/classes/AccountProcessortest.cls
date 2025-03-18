@isTest
public class AccountProcessortest
{
    public static testMethod void testcountthecontacts(){
        
        Account actObj = new Account();
        actObj.Name = 'suman123';
        actObj.AnnualRevenue = 24000;
        insert actObj;
        
        Contact conObj = new Contact();
        conObj.LastName = 'sukumar123';
        conObj.Fax = '123456';
        conObj.AccountId = actObj.Id;
        
        insert conObj;
        
        set<Id> accountIdset = new set<Id>();
        accountIdset.add(actObj.Id);
        test.startTest();
        AccountProcessor.countthecontacts(accountIdset);
        test.stopTest();
        	
         Account actObj1 = [select id,name,No_Of_Contacts__c from account where Id in : accountIdset];
        system.assertEquals(Integer.valueOf(actObj1.No_Of_Contacts__c), 1);
        
        
    }
    
    
}