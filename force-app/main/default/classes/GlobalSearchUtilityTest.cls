@isTest
public class GlobalSearchUtilityTest 
{
    public static testMethod void searchRecordsTest()
    {
        Account actObj = new Account();
        actObj.Name = 'pavan kumar';
        actObj.Rating = 'Hot';
        actObj.AnnualRevenue = 3000;
        insert actObj;
        
        Case caseObj = new Case();
        caseObj.Status = 'New';
        caseObj.Priority = 'Medium';
        caseObj.Origin = 'Phone';
        caseObj.Comments = 'Pavan Kumar comments';
        caseObj.Subject = 'pavan world';
        insert caseObj;
        
        Opportunity optObj = new Opportunity();
        optObj.Name = 'pavan opportunity';
        optObj.CloseDate = system.today() + 10;
        optObj.StageName = 'Closed Won';
        
        insert optObj;
    
        Id [] fixedSearchResults= new Id[3];
        fixedSearchResults[0] = actObj.Id;
        fixedSearchResults[1] = caseObj.Id;
        fixedSearchResults[2] = optObj.Id;
        Test.setFixedSearchResults(fixedSearchResults);
        test.startTest();
          GlobalSearchUtility.searchRecords();        
        test.stopTest();
       
    }
    
     public static testMethod void dynamicSearchRecordsTest()
    {
        Account actObj = new Account();
        actObj.Name = 'pavan kumar';
        actObj.Rating = 'Hot';
        actObj.AnnualRevenue = 3000;
        insert actObj;
        
        Case caseObj = new Case();
        caseObj.Status = 'New';
        caseObj.Priority = 'Medium';
        caseObj.Origin = 'Phone';
        caseObj.Comments = 'Pavan Kumar comments';
        caseObj.Subject = 'pavan world';
        insert caseObj;
        
        Opportunity optObj = new Opportunity();
        optObj.Name = 'pavan kumar';
        optObj.CloseDate = system.today() + 10;
        optObj.StageName = 'Closed Won';
        
        insert optObj;
    
        position__c pObj = new position__c();
        pObj.Name = 'java developer';
        pObj.Number_Of_Vacancies__c = 3;
        pObj.Location__c = 'bangalore';
        poBj.Position_Status__c = 'New Position';
        pObj.Minimum_Pay__c = 39000;
        pObj.Maximum_Budget__c = 4000000;
        pObj.Open_date__c = system.today();
        pObj.MileStone_Date__c = system.today() + 10;
        pObj.HR_Email_ID__c = 'a@gmail.com';
        
        insert pObj;
        
        
        Id [] fixedSearchResults= new Id[4];
        fixedSearchResults[0] = actObj.Id;
        fixedSearchResults[1] = caseObj.Id;
        fixedSearchResults[2] = optObj.Id;
         fixedSearchResults[3] = pObj.Id;
        Test.setFixedSearchResults(fixedSearchResults);
        test.startTest();
          GlobalSearchUtility.dynamicSearchRecords('sdjkavsdjkb');        
        test.stopTest();
       
    }


}