@isTest
public class AccountCreationControllerTest 
{
    @isTest
    public static  void saveAccountTest(){
        Account testaccountObj = Test_DataFactory.prepareAcconts(false);
        Test.startTest();
        AccountCreationController actObj2 = new AccountCreationController();
        actObj2.actObj = testaccountObj;
        actObj2.saveAccount();
        Test.stopTest();
        Account actObj3 = [select Id,Name from Account where Name=:'rajaaccount'];
        system.assert(actObj3.Id != null,'Id should not be empty');
        
    }

    @isTest
    public static void insertAccountRecordTest()
    {
      Account actObj = new Account();
      actObj.Name = 'sankar mohan';
      actObj.Phone = '12345666';
      actObj.Rating = 'Hot';
      actObj.Industry = 'Other';

      Account actObj2 = new Account();
      // actObj2.Name = 'sankar mohan';
      actObj2.Phone = '12345666';
      actObj2.Rating = 'Hot';
      actObj2.Industry = 'Other';
      Test.startTest();
      Account returnedObject = AccountCreationController.insertAccountRecord(actObj);
      System.assert(returnedObject.Id != null, 'account Id should not be empty');
      AccountCreationController.insertAccountRecord(actObj2);
      Test.stopTest();
    }
}