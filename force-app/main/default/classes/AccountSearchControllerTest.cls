@isTest
public with sharing class AccountSearchControllerTest 
{
    @TestSetup
   public static void makeData()
   {
     List<Account> actList = new List<Account>();
       for(integer i = 0; i <=5;i++)
       {
        Account actObj = new Account();
        actObj.Name = 'raja ' + i;
        actObj.Phone = '830935186'+ i;
        actObj.Rating = 'Hot';
        actList.add(actObj);
       } 
       insert actList;
   }

   @isTest
   public static void searchAccountsTest()
   {
    String actname = 'raja';
    String myActName = null;
    Test.startTest();
      List<Account> returnedActList = AccountSearchController.searchAccounts(actName);
      System.assertEquals(returnedActList.size(), 6, 'account records size should be same');
      AccountSearchController.searchAccounts(myActName);
    Test.stopTest();

   }
   
}