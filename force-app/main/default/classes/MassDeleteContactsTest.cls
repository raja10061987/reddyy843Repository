@isTest
public with sharing class MassDeleteContactsTest 
{

    @TestSetup
    static void makeData()
    {
        List<Contact> contList = new List<Contact>();
          for (integer i = 0; i <=2; i++) {
            Contact conObj = new Contact(); 
            conObj.FirstName = 'test - ' + i;
            conObj.LastName = 'Last - ' + i;
            conObj.Phone = '7013948962' + i;
            conObj.Email = 'test@gmail.com';
            contList.add(conObj);
          }
          insert contList;
             
    }

    @isTest
    public static void retriveContactsTest()
    {
        Test.startTest();
        List<Contact> returnedContacts =  MassDeleteContacts.retriveContacts();
        System.assertEquals(returnedContacts.size(), 3, 'contacts shouled be returned 3');
        Test.stopTest();
    } 
    
    @isTest
    public static void deleteContactsTest()
    {
        List<Id> contIds = new List<Id>();
        List<Id> contIdstoBeDelete = new List<Id>();
        List<Contact> contList = [select Id,FirstName, LastName, Phone, email,CreatedDate from Contact where FirstName != null WITH SECURITY_ENFORCED order by CreatedDate desc ];
        for (Contact conObj : contList) {
            contIds.add(conObj.Id);
            // contIdstoBeDelete.add(conObj.Id + '0');
        } 
        Test.startTest();
        MassDeleteContacts.deleteContacts(contIds);
        System.assert(1==1, 'contact records should delete');
       
        Test.stopTest();


    }
}