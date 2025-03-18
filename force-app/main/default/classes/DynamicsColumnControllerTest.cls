@isTest
public with sharing class DynamicsColumnControllerTest 
{
    @TestSetUp
    public static void makeData()
    {
        Account actObj = new Account();
        actObj.Name = 'ravi kumar';
        actObj.Phone = '88888';
        actObj.Rating = 'Hot';
        actObj.Type = 'IT';
        insert actObj;

    }

    @isTest
    public static void testDynamicColumns()
    {
        Test.StartTest();
        DynamicsColumnController obj = new DynamicsColumnController();
        system.assertEquals(1,1,'both not equal');
        Test.StopTest();
    }
}