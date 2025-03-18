@isTest()
public with sharing class ExtensionController1Test 
{
    @TestSetup
    static void makeData()
    {
        List<Account> actList = new List<Account>();
        
        for (integer i = 0; i<=10; i++) {
            Account actObj = new Account();
            actObj.name = 'suman - ' + i;
            actObj.Rating = 'Hot';
            actObj.phone = '12333';
            actObj.Industry = 'Agroculture';
            actList.add(actObj);
        }
        insert actList;
        
    }
     
   
    @isTest
    public static  void  methodTest()
    {
        test.startTest();
  
        Account obj = new Account(Name ='Test');
         insert obj;

         PageReference pageRef = Page.AccountCreationStandardController1;
         Test.setCurrentPage(pageRef);
         ApexPages.StandardController sc = new ApexPages.StandardController(obj);
         ExtensionController1 testAccPlan = new ExtensionController1(sc);
        test.stopTest();
    }
}