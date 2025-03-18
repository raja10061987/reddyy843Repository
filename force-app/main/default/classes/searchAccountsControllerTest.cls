@isTest
public class searchAccountsControllerTest 
{
   public static testMethod void serachAccountsTest()
   {
       Account actObj = new account();
       actObj.Name = 'pavan';
       actObj.Fax = '1234';
       actObj.Phone = '8309351867';
       actObj.Website= 'www.website.com';
       actObj.AccountNumber = '12334';
       actObj.Type = 'Other';
       actObj.Rating = 'Hot';
       actObj.Industry = 'Hospitality';
       insert actObj;
       
       test.startTest();
       searchAccountsController obj = new searchAccountsController();
        obj.searchText = 'pavan';
        obj.serachAccounts();
        searchAccountsController obj1 = new searchAccountsController();
        obj1.searchText = '';
        obj1.serachAccounts();
       searchAccountsController obj2 = new searchAccountsController();
        obj2.searchText = 'hell raja';
        obj2.serachAccounts();
       test.stopTest();
   }
}