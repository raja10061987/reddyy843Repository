@isTest
public class AutoPopulateAnnualRevenueTest 
{
    public static testMethod void AutoPopulateAccountAnnualRevenueTest()
    {
        Account actObj = new Account();
        actObj.Name = 'raja';
        actObj.Rating = 'Hot';
        actObj.Industry = 'Banking';
        
        Account actObj2 = new Account();
        actObj2.Name = 'raja';
        actObj2.Rating = 'Hot';
        actObj2.Industry = 'Finance';
        
        Account actObj3 = new Account();
        actObj3.Name = 'raja';
        actObj3.Rating = 'Hot';
        actObj3.Industry = 'HealthCare';
        
        Account actObj4 = new Account();
        actObj4.Name = 'raja';
        actObj4.Rating = 'Hot';
        actObj4.Industry = 'Other';
        
        Account actObj5 = new Account();
        actObj5.Name = 'raja';
        actObj5.Rating = 'Hot';
        actObj5.Industry = 'Insurance';
        
        test.startTest();
        insert actObj;
        insert actObj2;
        insert actObj3;
        insert actObj4;
        insert actObj5;
        test.stopTest();
    }
    
    public static testMethod void preventDeleteionActiveAccountRecordsTest()
    {
        
        Account actObj6 = new Account();
        actObj6.Name = 'rama kumar';
        actObj6.Rating = 'Hot';
        actObj6.Active__c = 'Yes';
        insert actObj6;
        system.debug('actObj6: ' + actObj6);
        test.startTest();
        delete actObj6;
        test.stopTest();
    }
    
    public static testMethod void preventdeletionContactsTest()
    {
        Account actObj = new Account();
        actObj.Name = 'raja';
        actObj.Rating = 'Hot';
        actObj.Industry = 'Banking';
        
        insert actObj;
        system.debug('actObj Id: ' + actObj.Id);
        
        Contact conObj = new Contact();
        conObj.LastName = 'suman';
        conObj.Phone = '12344';
        conObj.Email = 'a@gmail.com';
        conObj.AccountId = actObj.id;
        
        insert conObj;
        system.debug('conObj: ' + conObj);
        List<contact> contactList = [select id,Lastname,name,accountId from contact where accountId=:actObj.Id];
        system.debug('mycontactList: ' + contactList);
        
       test.startTest();
        delete actObj;
       test.stopTest();
    }
    
    public static testMethod void synchronizAccountPhoneTax()
    {
        Account actObj = new Account();
        actObj.Name = 'raja';
        actObj.Rating = 'Hot';
        actObj.Phone = '1233';
        actObj.Fax = '4456';
        insert actObj;
        
        Contact conObj = new Contact();
        conObj.LastName = 'suman';
        conObj.Phone = '12344';
        conObj.Fax = '7777';
        conObj.Email = 'a@gmail.com';
        conObj.AccountId = actObj.id;
        insert conObj;
        
        test.startTest();
        actObj.Phone = '1111';
        actObj.Fax = '222';
        update actObj;
        test.stopTest();
        
    }

}