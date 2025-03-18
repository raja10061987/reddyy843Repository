@isTest
public class AccountsPaginationControllerTest 
{
   public static testMethod void getAccountsTest()
   {
       Account actObj = new Account();
       actObj.Name = 'suman';
       actObj.Phone = '1234455';
       actObj.Fax = '798789';
       actObj.Industry = 'Hospitality';
       actObj.Rating = 'Hot';
       insert actObj;
       
       test.startTest();
       AccountsPaginationController obj = new AccountsPaginationController();
       obj.getAccounts();
       test.stopTest();       
   }
}