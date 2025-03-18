@isTest
public class AccountsQueableTest 
{
    public static testMethod void accountsExecuteTest()
    {
        AccountsQueable.doChainJob = false;
        AccountsQueable obj = new AccountsQueable();
        
         test.startTest();
        Id accountjobId = System.enqueueJob(obj);
        test.stopTest();
       
        
    }

}