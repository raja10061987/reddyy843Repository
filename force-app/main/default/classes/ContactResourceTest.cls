@isTest
public class ContactResourceTest 
{
    @testSetUp
    public static void makeData()
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
        
        Contact conObj1 = new Contact();
        conObj1.FirstName = 'Rajasekhar1';
        conObj1.LastName = 'reddy1';
        conObj1.Phone = '83093518670';
        conObj1.Email = 'aa1@gmail.com';
        conObj1.AccountId = actObj.Id;
        insert conObj1;
        system.debug('setup conObj: ' + conObj);
        system.debug('setup conObj1: ' + conObj1);
        
    }
    
   
    public static testMethod void  deleteMultipleContactsTest()
    {
        set<Id> contactIdsList = new set<Id>();
        List<Contact> contList = [select id,FirstName from Contact];
        system.debug('contList: ' + contList);
        for (Contact conObj:contList)
        {
            contactIdsList.add(conObj.Id);
        }
        system.debug('contactIdsList: ' + contactIdsList);
        integer i= 0;
        Id ContactId1;
        Id ContactId2;
        for(Id conatctId: contactIdsList)
        {
            if(i == 0)
            {
                ContactId1 = conatctId;
                i++;
            }
            else
            {
                ContactId2 = conatctId;
            }
            
        }
        system.debug('ContactId1: ' + ContactId1);
        system.debug('ContactId2: ' + ContactId2);
        restRequest contrestRequest = new restRequest();
        contrestRequest.requestURI = 'https://workbench.developerforce.com/services/apexrest/ContactAPI/' + ContactId1 + ','+ ContactId2;
        contrestRequest.httpMethod = 'Delete';
        restContext.request = contrestRequest;
        system.debug('contrestRequest: ' + contrestRequest);
        system.debug('restContext.request: ' + restContext.request);
        
        test.startTest();
        ContactResource.deleteMultipleContacts();
        ContactResource.deleteMultipleContacts();
        test.stopTest();
        
        
    }
  
    
}