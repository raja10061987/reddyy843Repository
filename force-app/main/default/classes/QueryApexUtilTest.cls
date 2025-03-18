@isTest
public with sharing class QueryApexUtilTest 
{
    @TestSetup
    public static void makeData()
    {
        Account actObj = new Account();
        actObj.Name = 'suman';
        actObj.Rating = 'Hot';
        actObj.AnnualRevenue = 3000;
        actObj.Description = 'hello account';
        insert actObj;

    }

    @isTest
    public static void retriveDataTest()
    {
        Test.startTest();
        List<SObject> mySobjectList = QueryApexUtil.retriveData('Account');
        System.debug('mySobjectList: ' + mySobjectList.size());
        System.debug('mySobjectList: ' + mySobjectList);
        System.assertEquals(mySobjectList.size() > 0, true, 'account List size should not be empty');

        Test.stopTest();
    }

    @isTest
    public static void getValuesTest()
    {
        test.startTest();
        QueryApexUtil obj = new QueryApexUtil();
        VisualEditor.DynamicPickListRows pickListRows =obj.getValues();
        obj.getDefaultValue();
        System.debug('pickListRows: ' + pickListRows);
        System.assertEquals(pickListRows.size() > 0, true, 'picklist Size should not be empty');
        test.stopTest();
    }
   
}