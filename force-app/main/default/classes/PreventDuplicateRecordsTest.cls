@isTest
public class PreventDuplicateRecordsTest 
{
    public static testmethod void preventDuplicateRecordswithnameTest()
    {
        position__c pObj = new position__c();
        pObj.Name = 'dot net developer';
        pObj.Location__c = 'bangalore';
        pObj.Number_Of_Vacancies__c = 2;
        pObj.Maximum_Budget__c = 23000;
        pObj.MileStone_Date__c = system.today() + 10;
        pObj.HR_Email_ID__c = 'a@gmail.com';
        pObj.Open_date__c = system.today();
        
        insert pObj;
        system.debug('position Record: ' + pObj.Id);
        
        candidate__c canObj1 = new Candidate__C();
        canObj1.Phone__c = '1132312';
        canObj1.Email_id__c = 'r@gmail.com';
        canObj1.Notice_period__c = '1 month';
        canObj1.Name = 'ravi';
        canObj1.Location__c = 'chennai';
        canObj1.Experience__c = 12;
        canObj1.Expected_CTC__c = 120000;
        canObj1.Position__c = pObj.id;
        insert canObj1;
        
        candidate__c canObj2 = new Candidate__C();
        canObj2.Phone__c = '1132312';
        canObj2.Email_id__c = 'r@gmail.com';
        canObj2.Notice_period__c = '1 month';
        canObj2.Name = 'ravi';
        canObj2.Location__c = 'chennai';
        canObj2.Experience__c = 12;
        canObj2.Expected_CTC__c = 120000;
        canObj2.Position__c = pObj.id;
        
        test.startTest();
        insert canObj2;
        test.startTest();
        system.debug('candidate name: ' + canObj2.Name);
    }

}