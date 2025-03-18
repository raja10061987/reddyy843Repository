@isTest
public class myContactResource1Test 
{
    @testSetUp
    public static void makedata()
    {
        Account actObj = new Account();
        actObj.Name = 'suman';
        actObj.Rating = 'Hot';
        actObj.Phone = '99999';
        insert actObj;
        system.debug('actObj: ' + actObj);
        
        List<Contact> contList = new List<Contact>();
        for (integer i = 0; i < 5; i ++)
        {
            Contact conObj = new Contact();
            conObj.FirstName = 'Raja - ' + i;
            conObj.LastName = 'reddy';
            conObj.Phone = '8309251867';
            conObj.Email = 'aa@gmail.com';
            conObj.AccountId = actObj.Id;
            contList.add(conObj);
        }
       system.debug('contList: ' + contList);
        insert contList;
        
    }
    
    public static testMethod void getContactsTest()
    {
        test.startTest();
       List<Contact> returnedContacts = myContactResource1.getContacts(1);
        system.debug('returnedContacts: ' + returnedContacts);
        System.assert(returnedContacts != null);
        System.assert(returnedContacts.size() == 1);
        System.assertEquals('Raja - 0 reddy', returnedContacts[0].Name);  // Raja - 0 reddy,
        
        
        test.stopTest();
    }

}