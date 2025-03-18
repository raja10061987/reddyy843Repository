@isTest
public class ShowAllAccountsControllerTest 
{
    public static testMethod  void ShowAllAccountsTest()
    {
        List<Account> actList = New List<Account>();
        for(integer counter= 1; counter<=10;counter++){
        Account actObj = new Account();
        actObj.Name = 'Raja' + counter;
        actObj.Rating = 'Hot';
        actObj.AccountNumber = '475634756';
        actObj.Active__c = 'Yes';
        actObj.AnnualRevenue = 30000;
        actObj.BillingCity = 'Hyderabad';
        actObj.Fax = '987999';
        actList.add(actObj);
        }
         if(!actList.isEmpty())
         {
             insert actList;
         }
  
      test.startTest();
      ShowAllAccountsController obj = new ShowAllAccountsController();
      obj.getAllAccounts();
      test.stopTest();
 
    }
   
}