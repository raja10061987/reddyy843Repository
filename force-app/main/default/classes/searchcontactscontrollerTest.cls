@isTest
public class searchcontactscontrollerTest {

     public static testMethod void getsearchContactsTest()
     {
         account actObj = new account();
         actObj.name = 'suman';
         actObj.Rating = 'Hot';
         insert actObj;
         
         contact conObj = new contact();
         conObj.firstname = 'raja';
         conObj.lastName = 'pavan';
         conObj.Phone = '1211';
         conObj.Email = 'a@gmail.com';
         conObj.AccountId = actObj.Id;
         insert conObj;
         system.debug('anonymous: ' + conObj);
         
         test.startTest();
         searchcontactscontroller obj = new searchcontactscontroller();
         obj.searchText = 'raja pavan';
         obj.getsearchContacts();
         obj.searchText = '';
         obj.getsearchContacts();
         test.stopTest();
         
     }
}