@IsTest
public class AccountListOptionsControllerTest 
{
    public static testMethod void getRelatedContactsByAccountIdTest()
    {
        Account actObj = new Account();
        actObj.name= 'raja';
        actObj.AccountNumber = '123456';
        actObj.Rating = 'Hot';
        insert actObj;
         Account actObj1 = new Account();
        actObj1.name= 'raja1';
        actObj1.AccountNumber = '123456900';
        actObj1.Rating = 'Hot';
        insert actObj1;
        // insert contact record
        Contact contObj = new Contact();
        contObj.firstName = 'suman';
        contObj.LastName = 'reddy';
        contObj.phone = '12222';
        contObj.email = 'a@gmail.com';
        contObj.accountId = actObj.Id;
        insert contObj;
        test.startTest();
        AccountListOptionsController obj = new AccountListOptionsController();
        obj.selectedaccountId = actObj.Id;
        obj.getRelatedContactsByAccountId();
        obj.selectedaccountId = actObj1.Id;
        OBJ.getRelatedContactsByAccountId();
        test.stopTest();
    }

}