@isTest
public class HiringManagerTest 
{
    public static testMethod void checkDuplicateRecordsTest()
    {
        Hiring_Manager__c hrObj1 = new Hiring_Manager__C();
        hrObj1.Name = 'pavan';
        hrObj1.Contact_Number__c = '8309351867';
        hrObj1.Designation__c = 'Hr Executive';
        hrObj1.Location__c = 'Bangalore';
        hrObj1.Email_Id__c = 'reddyy843@gmail.com';
        insert hrObj1;
        
        hrObj1.Designation__c = 'Sr Executive';
        test.startTest();
        update hrObj1;
        test.stopTest();
        
    }
    public static testMethod void AutosyncHiringManagerRecruiterTest()
    {
        Hiring_Manager__c hrObj1 = new Hiring_Manager__C();
        hrObj1.Name = 'pavan';
        hrObj1.Contact_Number__c = '8309351867';
        hrObj1.Designation__c = 'Hr Executive';
        hrObj1.Location__c = 'Bangalore';
        hrObj1.Email_Id__c = 'reddyy843@gmail.com';
        
        test.startTest();
        insert hrObj1;
        test.stopTest();
        
    }
    
     public static testMethod void AutoUpdateHiringManagerRecruiter()
    {
        Hiring_Manager__c hrObj1 = new Hiring_Manager__C();
        hrObj1.Name = 'pavan';
        hrObj1.Contact_Number__c = '8309351867';
        hrObj1.Designation__c = 'Hr Executive';
        hrObj1.Location__c = 'Bangalore';
        hrObj1.Email_Id__c = 'reddyy843@gmail.com';
        insert hrObj1;
        
        Recruiter__c recObj = new Recruiter__c();
        recObj.Name = 'kavan';
        recObj.Designation__c = 'Sr Executive';
        recObj.Phone_Number__c = '7777777';
        recObj.City_Name__c = 'Dilhi';
        recObj.Email_Address__c = 'a@gmail.com';
        recObj.Hiring_Manager_id__c = hrObj1.Id;
        
        
        hrObj1.Name = 'suman';
        hrObj1.Contact_Number__c = '8888';
        hrObj1.Designation__c = 'Hr Executive';
        hrObj1.Location__c = 'chennai';
        hrObj1.Email_Id__c = 'redd8434@gmail.com';
        
        test.startTest();
         update hrObj1;
        test.stopTest();
        
    }
    
    
     public static testMethod void AutoUpdateRecruiterToHiringManagerTest()
    {
        Hiring_Manager__c hrObj1 = new Hiring_Manager__C();
        hrObj1.Name = 'pavan';
        hrObj1.Contact_Number__c = '8309351867';
        hrObj1.Designation__c = 'Hr Executive';
        hrObj1.Location__c = 'Bangalore';
        hrObj1.Email_Id__c = 'reddyy843@gmail.com';
        insert hrObj1;
        
        Recruiter__c recObj = new Recruiter__c();
        recObj.Name = 'kavan';
        recObj.Designation__c = 'Sr Executive';
        recObj.Phone_Number__c = '7777777';
        recObj.City_Name__c = 'Dilhi';
        recObj.Email_Address__c = 'a@gmail.com';
        recObj.Hiring_Manager_id__c = hrObj1.Id;
        insert recObj;
        
        // update recuriter fields
        
        recObj.Name = 'kavan1';
        recObj.Designation__c = 'Hr Executive';
        recObj.Phone_Number__c = '88888';
        recObj.City_Name__c = 'chennai';
        recObj.Email_Address__c = 'a1@gmail.com';
        
        
        test.startTest();
         update recObj;
        test.stopTest();
        
    }
    
     public static testMethod void HiringManagerRecordsSharingTest()
    {
        User userRecord = [SELECT Id, Username, LastName, FirstName, Name, Email, IsActive FROM User where Username='reddyy700@gmail.com'];
        Hiring_Manager__c hrObj1 = new Hiring_Manager__C();
        hrObj1.Name = 'sharingtest';
        hrObj1.Contact_Number__c = '11111';
        hrObj1.Designation__c = 'Hr Executive';
        hrObj1.Location__c = 'Bangalore';
        hrObj1.Email_Id__c = 'reddyy843@gmail.com';
        hrObj1.Share_Record_To__c = userRecord.Id;
       
      
        test.startTest();
        insert hrObj1;
        test.stopTest();
        
    }
    
     public static testMethod void shareHRRecordsAfterUpdateTest()
    {
        Profile pf= [Select Id from profile where Name='System Administrator']; 
        String orgId=UserInfo.getOrganizationId(); 
        String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName=orgId+dateString+RandomId; 
        User user1=new User(firstname = 'ABC', 
                         lastName = 'XYZ', 
                         email = uniqueName + '@test' + orgId + '.org', 
                         Username = uniqueName + '@test' + orgId + '.org', 
                         EmailEncodingKey = 'ISO-8859-1', 
                         Alias = uniqueName.substring(18, 23), 
                         TimeZoneSidKey = 'America/Los_Angeles', 
                         LocaleSidKey = 'en_US', 
                         LanguageLocaleKey = 'en_US', 
                         ProfileId = pf.Id
                        ); 
         User user2=new User(firstname = 'pavan', 
                         lastName = 'reddy', 
                         email = uniqueName + '@test' + orgId + '.org1', 
                         Username = uniqueName + '@test' + orgId + '.org1', 
                         EmailEncodingKey = 'ISO-8859-1', 
                         Alias = uniqueName.substring(18, 23), 
                         TimeZoneSidKey = 'America/Los_Angeles', 
                         LocaleSidKey = 'en_US', 
                         LanguageLocaleKey = 'en_US', 
                         ProfileId = pf.Id
                        ); 
        insert user1;
        insert user2;
        
        Hiring_Manager__c hrObj1 = new Hiring_Manager__C();
        hrObj1.Name = 'sharingupdatetest';
        hrObj1.Contact_Number__c = '77777';
        hrObj1.Designation__c = 'Hr Executive';
        hrObj1.Location__c = 'Bangalore';
        hrObj1.Email_Id__c = 'reddyy1843@gmail.com';
        hrObj1.Share_Record_To__c = user1.id;
        insert hrObj1;  
        
        hrObj1.Share_Record_To__c = user2.Id;
        test.startTest();
        update hrObj1;
        test.stopTest();
       
    }
    
     public static testMethod void getAzureCredentialsTest()
    {
        
        AzureBlobCredentials__c azureObj = new AzureBlobCredentials__c();
        azureObj.Name = 'AzureBlob';
        azureObj.Endpoint__c = 'https://azure.microsoft.com/en-us/';
        insert azureObj;
        
        
        Hiring_Manager__c hrObj1 = new Hiring_Manager__C();
        hrObj1.Name = 'axis';
        hrObj1.Contact_Number__c = '999999999';
        hrObj1.Designation__c = 'Hr Executive';
        hrObj1.Location__c = 'Bangalore';
        hrObj1.Email_Id__c = 'axis@gmail.com';
        hrObj1.Azure_Name__c = 'AzureBlob';
       
        
        test.startTest();
         insert hrObj1;
        test.stopTest();
        system.debug('azure name: ' + hrObj1.Azure_Name__c);
        system.debug('azure EndPoint: ' + hrObj1.End_Point__c);
        
    }
    
    public static testMethod void deleteAllRecuruitersRelatedtoHRRecordsTest()
    {
        Hiring_Manager__c hrObj1 = new Hiring_Manager__C();
        hrObj1.Name = 'sachin tendulkar';
        hrObj1.Contact_Number__c = '999999999999999';
        hrObj1.Designation__c = 'Hr Executive';
        hrObj1.Location__c = 'Bangalore';
        hrObj1.Email_Id__c = 'reddyy1843@gmail.com';
        insert hrObj1;
        
        Recruiter__c recObj = new Recruiter__c();
        recObj.Name = 'kavan';
        recObj.Designation__c = 'Sr Executive';
        recObj.Phone_Number__c = '7777777';
        recObj.City_Name__c = 'Dilhi';
        recObj.Email_Address__c = 'a@gmail.com';
        recObj.Hiring_Manager_id__c = hrObj1.Id;
        
        insert recObj;
        test.startTest();
        delete hrObj1;
        test.stopTest();
        
    }
    
}