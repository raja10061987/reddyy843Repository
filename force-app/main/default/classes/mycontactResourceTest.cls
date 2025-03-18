@isTest
public  class mycontactResourceTest 
{
    @testSetup
    static void makeData()
    {
        Account actObj = new Account();
        actObj.Name = 'parent account';
        actObj.Rating = 'Hot';
        insert actObj;
        
        Contact conObj = new Contact();
        conObj.FirstName = 'Rajasekhar';
        conObj.LastName = 'reddy';
        conObj.Phone = '8309351867';
        conObj.Email = 'aa@gmail.com';
        conObj.AccountId = actObj.Id;
        insert conObj;
        system.debug('setup conObj: ' + conObj);
    }
    
     static testMethod  void getContactsTest()
    {
       test.startTest();
        restRequest contactContext = new restRequest();
        contactContext.requestURI = 'https://spglobalpvtltd-dev-ed.my.salesforce.com/services/apexrest/mycontactresource1/1';
        contactContext.httpMethod = 'Get';
        restContext.request = contactContext;
        
        List<contact> contList = mycontactResource.getContacts();
        system.debug('test method contList: ' + contList);
       	System.assert(contList != null);
        System.assert(contList.size() == 1);
        System.assertEquals('Rajasekhar reddy', contList[0].Name);        
       test.stopTest();
    }
    
    static testMethod void createContactTest()
    {
     Contact returnedContact = mycontactResource.createContact('ravi1','reddy2','05/02/2022','Web','8309351867','reddyy843@gmail.com');
      system.debug('returnedContact: ' + returnedContact);
        system.assert(returnedContact != null);
        system.assert(returnedContact.Id != null);
        
        Contact quriedContact = [select LeadSource from Contact where Id =:returnedContact.Id];
        system.debug('quriedContact: ' + quriedContact);
        System.assertEquals(returnedContact.LeadSource, quriedContact.LeadSource);
    }
    
    static testMethod void updateContactTest()
    {
        Id contactId = [select id from contact Limit 1].id;
        Contact conObj = new Contact();
        conObj.FirstName = 'Rajasekhar1';
        conObj.LastName = 'reddy1';
       
        
        restRequest mycontacRequest = new restRequest();
        mycontacRequest.requestURI = 'spglobalpvtltd-dev-ed.my.salesforce.com/services/apexrest/mycontactresource1/' + contactId;
        mycontacRequest.httpMethod = 'Patch';
        mycontacRequest.requestBody = Blob.valueOf(JSON.serialize(conObj));
        restContext.request = mycontacRequest;
        
      
       test.startTest();
      Contact returnedContact =  mycontactResource.updateContact();
        system.debug('returnedContact: ' + returnedContact);
        System.assert(returnedContact != null);
        system.assert(returnedContact.id != null);
        Contact quriedContact = [select firstName,LastName from Contact where Id =:returnedContact.ID];
        system.debug('quriedContact: ' + quriedContact);
        System.assertEquals(returnedContact.FirstName, quriedContact.FirstName);
        
       test.stopTest();
        
        
        
    }
    
    static testMethod void deleteContactTest()
    {
        Id contactId = [select Id from Contact Limit 1].Id;
        system.debug(' test  contactId: ' + contactId );
        
        restRequest myrestRequest = new restRequest();
        myrestRequest.httpMethod = 'Delete';
        myrestRequest.requestURI = 'https://spglobalpvtltd-dev-ed.my.salesforce.com/services/apexrest/mycontactresource1/' + contactId;
        restContext.request = myrestRequest;
        system.debug('test myrestRequest: ' + myrestRequest);
        test.startTest();
        Map<String,String> returnedResourceMap = mycontactResource.deleteContact();
        System.assertEquals('1',returnedResourceMap.get('success'));
         Map<String,String> returneddeleteResourceMap = mycontactResource.deleteContact();
        System.assertEquals('0',returneddeleteResourceMap.get('success'));
       
        test.stopTest();
       
        
    }

}