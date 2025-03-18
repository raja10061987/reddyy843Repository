@IsTest
public class testAccountInsert {
        public static testMethod void testcreateContacts(){
        Account actObj = new Account();
        actObj.name = 'rajaccount';
        actObj.Type= 'Other';
        actObj.Industry = 'Banking';
        test.startTest();
        insert actObj;
        test.startTest();
        Contact conObj= [select Id,name from Contact where accountId =: actObj.Id limit 1];
        system.assert(conObj.Id != null);
    }
    
    public static testMethod void testCreateOpportunities(){
        Account actObj = new Account();
        actObj.name = 'rajaccount1';
        actObj.Type= 'Other';
        actObj.Industry = 'Banking';
        insert actObj;
        test.startTest();
        actObj.Industry = 'Insurance';
        update actObj;
        test.stopTest();
        Opportunity opObj = [select Id,Name from Opportunity where AccountId =: actObj.Id];
        system.assert(opObj.Id != null);

        
    }
}