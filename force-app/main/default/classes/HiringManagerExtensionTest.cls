@isTest
public class HiringManagerExtensionTest {

    public static testMethod void CheckDuplicateHRRcordsTest()
    {
        Hiring_manager__C hrObj1 = new Hiring_manager__C();
        hrObj1.Name = 'raja';
        hrObj1.Email_Id__c = 'reddyy843@gmail.com';
        hrObj1.Location__c = 'Hyderabad';
        hrObj1.Contact_Number__c = '830351867';
        insert hrObj1;
         Hiring_manager__C hrObj2 = new Hiring_manager__C();
        hrObj2.Name = 'raja3';
        hrObj2.Email_Id__c = 'reddyy843@gmail.com';
        hrObj2.Location__c = 'Hyderabad';
        hrObj2.Contact_Number__c = '830351867';
        insert hrObj2;
         Hiring_manager__C hrObj3 = new Hiring_manager__C();
        hrObj3.Name = 'raja4';
        hrObj3.Email_Id__c = 'reddyy843@gmail.com';
        hrObj3.Location__c = 'Hyderabad';
        hrObj3.Contact_Number__c = '830351867';
        insert hrObj3;
        test.startTest();
        Apexpages.StandardController sc = new Apexpages.StandardController(hrObj1);
         HiringManagerExtension extn = new HiringManagerExtension(sc);
      extn.CheckDuplicateHRRcords();
        test.stopTest();
        
    }
    
  
}