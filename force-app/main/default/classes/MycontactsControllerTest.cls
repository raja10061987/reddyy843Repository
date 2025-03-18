@isTest
public with sharing class MycontactsControllerTest 
{ 
    @TestSetup
   public static void makeData()
   {
         Account actObj = new Account();
        actObj.Name = 'suman';
        actObj.Rating = 'Hot';
        actObj.Website = 'www.website.com';
        insert actObj;

    Contact conObj1 = new Contact();
    conObj1.FirstName = 'suman';
    conObj1.LastName = 'reddy';
    conObj1.Email = 'aa@gmail.com';
    conObj1.Phone = '123456789';
    conObj1.AccountId = actObj.id;
    insert conObj1;
    

    Contact conObj2 = new Contact();
    conObj2.FirstName = 'pavan';
    conObj2.LastName = 'reddy1';
    conObj2.Email = 'bb@gmail.com';
    conObj2.Phone = '89012345';
    conObj2.AccountId = actObj.id;

    insert conObj2;
        
   }
   @isTest
   public static  void saveContatctsTest()
   {
    List<Contact> contList = [select phone,Email,FirstName, LastName from Contact  WITH SECURITY_ENFORCED];
    List<Contact> contList1 = [select phone,Email,FirstName from Contact  WITH SECURITY_ENFORCED];
    System.debug('contList@test: ' + contList);

    test.startTest();
    contList[0].Email = 'bb@gmail.com';
   Map<String,String> returnedMap = MyContactsController.saveContatcts(contList);
   contList1[0].Email = 'cc';
   Map<String,String> returnedMapwitherror = MyContactsController.saveContatcts(contList1);
   System.debug('returnedMap: ' + returnedMap);
   System.debug('returnedMapwitherror: ' + returnedMapwitherror);
   System.assertEquals(returnedMap.get('status'), 'success', 'data not updated succseefully');
   System.assertEquals(returnedMapwitherror.get('status'), 'error', 'contact should fail while updating record');

    test.stopTest();


     
   }

   @isTest
    public static void getContactsTest()
    {
    
        List<Id> actIds = new List<Id>();
        for(Account actObj: [select id,Name,Rating,Website from Account])
        {
            actIds.add(actObj.id);
        }
        System.debug('actIds: ' + actIds);
        
        test.startTest();
      List<Contact> contactList =  MyContactsController.getContacts(actIds);
      System.debug('contactList @test: ' + contactList);
       system.assertEquals(contactList.size() > 0, true, 'should be true');
        test.stopTest();

    }

   @IsTest
   public static void deleteContactsTest()
   {
    List<Contact> contList = [select id from Contact];
    List<Id> conIds = new List<Id>();
    for(Contact conObj: [select id from Contact])
    {
      conIds.add(conObj.Id);
    }
    Test.startTest();
  Map<String,String> returnedMap =  MyContactsController.removeContacts(conIds);
  System.debug('returnedMap: ' + returnedMap);
  System.assertEquals(returnedMap.get('status'), 'success', 'status should be success');
    Test.stopTest();

   }
   
   @IsTest
  public static void createContactTest()
  {
    Contact conObj1 = new Contact();
    conObj1.LastName = 'suman';
    conObj1.FirstName = 'sankar';
    conObj1.Phone = '123444';
    conObj1.Email = 'aa@gmail.com';
    System.debug('conObj1: ' + conObj1);
    Contact conObj = [select Id,LastName,FirstName,Phone,Email from Contact limit 1];
    System.debug('conObj@@: ' + conObj);
    test.startTest();
    Map<String,String> returnedResult = MyContactsController.createContact(conObj1);
    Map<String,String> returnedeerrorResult = MyContactsController.createContact(conObj);
      system.debug('returnedeerrorResult: ' + returnedeerrorResult);
     System.debug('returnedResult' + returnedResult);
     System.assertEquals(returnedResult.get('status'), 'success', 'should be success');
      System.assertEquals(returnedeerrorResult.get('status'), 'error', 'should be error');
    test.stopTest(); 

  }  
}