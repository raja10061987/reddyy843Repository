@isTest
public with sharing class ApexUtilTest {
   

    @isTest
    public static void getRecordidByNameTest()
    {
        Test.startTest();
      Map<String,Id> returnedRecordTypeNamevsId = ApexUtil.getRecordidByName('Account1');
      System.debug('returnedRecordTypeNamevsId: ' + returnedRecordTypeNamevsId);
        Test.stopTest();
        system.assertEquals(returnedRecordTypeNamevsId.keySet().size() > 0, returnedRecordTypeNamevsId.keySet().size() > 0, 'recordTyp Label Name should not be empty');
    }
}