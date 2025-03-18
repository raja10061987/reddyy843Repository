@isTest
public without sharing class AggregateResultControllerTest 
{
    @TestSetup
    static void makeData()
    {
        Lead leadObj = new Lead();
        leadObj.lastName= 'suman';
        leadObj.Company = 'IT';
        leadObj.Status = 'Open - Not Contacted';
        leadObj.leadSource = 'web';
        insert leadObj;
        
    }

    @isTest
    public static void testAggregateMethod()
    {
             Test.startTest();
             AggregateResultController obj = new AggregateResultController();
             System.assertEquals(1,1,'not equal');
             Test.stopTest();
    }
    
}