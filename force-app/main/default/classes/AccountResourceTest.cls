@IsTest
public class AccountResourceTest 
{
    @testSetUp
   public static void makedata()
   {
       Hiring_Manager__c hrObj = new Hiring_Manager__c();
       hrObj.Name = 'suman';
       hrObj.Location__c = 'Bangalore';
       hrObj.Designation__c = 'Hr Executive';
       hrObj.Email_Id__c = 'aa@gmail.com';
       hrObj.Contact_Number__c = '8309351867';
       
       insert hrObj;
       system.debug(' setup hrObj: ' + hrObj);
       
   }
    
    public static testMethod void upsertHRRecordTest()
    {
      Id hrId = [select id from Hiring_Manager__c limit 1].Id;    
        restRequest hrRestRequest = new restRequest();
        hrRestRequest.requestURI = '/services/apexrest/accountAPI/' + hrId;
        hrRestRequest.httpMethod = 'httpPut';
        restContext.request = hrRestRequest;
        system.debug('hrRestRequest: ' + hrRestRequest);
        test.startTest();
        Hiring_Manager__c returnedObj =  AccountResource.upsertHRRecord('suman', 'Bangalore', 'bb@gmail.com', '8309351867','Hr Executive');
        Hiring_Manager__c returnedObj1 =  AccountResource.upsertHRRecord('suman', 'Bangalore', '', '','Hr Executive');
        
        system.debug('test returnedObj: ' + returnedObj);
        system.debug('test returnedObj1: ' + returnedObj1);
        System.assert(returnedObj != null);
        test.stopTest();
            
    }
}