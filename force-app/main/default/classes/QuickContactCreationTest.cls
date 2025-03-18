@isTest
public with sharing class QuickContactCreationTest 
{
    @TestSetup
   public static void makeData()
   {
    Account actObj = new Account();
    actObj.Name = 'raja';
    actObj.Phone = '8309351867';
    actObj.Rating = 'Hot';
    actObj.Description = 'he is hot customer';
    insert actObj;

   }
   @isTest
   public static void createContactWithAccountDetailsTest()
   {
     String accountId = [select Id,Name,Phone,Rating,Description from Account].Id;
     test.startTest();
    String contactId =  QuickContactCreation.createContactWithAccountDetails(accountId);
    System.debug('anonymous ContactId: ' + contactId);
    System.assert(contactId != null, 'Contact should be created');
     test.stopTest();
   }
   @isTest
   public static void createContactTest()
   {
    Contact conObj = new Contact();
    conObj.FirstName = 'suman';
    conObj.LastName = 'reddy';
    conObj.Phone = '8309351867';
   Test.startTest();
    String returnedContactId =  QuickContactCreation.createContact(conObj);
    System.assert(returnedContactId != null, 'contact Id should not be empty');
   Test.stopTest();

   }    
}