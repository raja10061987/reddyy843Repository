@isTest
public class ContactDetailsValidationTriggerTest 
{
    public static testMethod void contactsPhoneValidationInsertTest()
    {
        Contact conObj1 = new Contact();
        conObj1.LastName = 'pavan890';
        test.startTest();
        insert conObj1;
        test.stopTest();
    }
    public static testMethod void contactsEmailValidationInsertTest()
    {
        Contact conObj2 = new Contact();
        conObj2.LastName = 'pavan890';
        conObj2.Phone = '809809908';
        test.startTest();
        insert conObj2;
        test.stopTest();
    }
     public static testMethod void contactsPhoneValidationUpdateTest()
    {
        Contact conObj1 = new Contact();
        conObj1.LastName = 'pavan890';
        conObj1.Phone = '12345678';
        conObj1.Email = 'a@gmail.com';
        insert conObj1;
        test.startTest();
        if(conObj1.Id != null){
            conObj1.Phone = '';
            update conObj1;
        }    
        test.stopTest();
    }
    
     public static testMethod void contactsEmailValidationUpdateTest()
    {
        Contact conObj1 = new Contact();
        conObj1.LastName = 'pavan890';
        conObj1.Phone = '12345678';
        conObj1.Email = 'a@gmail.com';
        insert conObj1;
        test.startTest();
        if(conObj1.Id != null){
            conObj1.Email = '';
            update conObj1;
        }    
        test.stopTest();
    }
    
    public static testMethod void MakesureContactsAssosiatedWithAccountsTest()
    {
        Contact conObj = new Contact();
        conObj.LastName = 'pavan123';
        conObj.Phone = '8309351867';
        conObj.Email = 'a@gmail.com';
        test.startTest();
        insert conObj;
        test.stopTest();
    }
    
    

}