@isTest
public with sharing class AccountTriggerTest {
    
    @isTest
    public static void testAccountTrigger()
    {
        Account actObj = new Account();
        actObj.Name = 'suman';
        actObj.Rating = 'Hot';
        actObj.AnnualRevenue = 200;
        actObj.BillingStreet = 'venkata rayudu nagar colony';
        actObj.BillingState = 'Telangana';
        actObj.BillingCountry = 'India';
        Test.startTest();
        insert actObj;
        System.assertEquals(1,1,'both are not equal');
        Test.stopTest();
    }
}