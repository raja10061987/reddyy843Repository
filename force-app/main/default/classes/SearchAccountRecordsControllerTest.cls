@IsTest
public class SearchAccountRecordsControllerTest 
{
    public static testMethod void searchRecordsTest()
    {
        // insert account record with name pavan
        Account actObj = new Account();
        actObj.Name = 'pavan kumar';
        actObj.Type = 'Other';
        actObj.Phone = '8309351867';
        actObj.Fax = '1111111';
        actObj.AnnualRevenue = 890000;
        actObj.Industry = 'Banking';
        actObj.Rating = 'Hot';
        
        insert actObj;
        system.debug('test class deubug: ' + actObj);
         
        test.startTest();
        SearchAccountRecordsController obj = new SearchAccountRecordsController();
        obj.searchstring = 'Pavan';
        obj.searchRecords();
        test.stopTest();
    }
    
    
     public static testMethod void searchRecords1Test()
    {
        // insert account record with name pavan
        Account actObj = new Account();
        actObj.Name = 'pavan kumar';
        actObj.Type = 'Other';
        actObj.Phone = '8309351867';
        actObj.Fax = '1111111';
        actObj.AnnualRevenue = 890000;
        actObj.Industry = 'Banking';
        actObj.Rating = 'Hot';
        
        insert actObj;
        system.debug('test class deubug: ' + actObj);
         
        test.startTest();
        SearchAccountRecordsController obj = new SearchAccountRecordsController();
        obj.searchstring = '';
        obj.searchRecords();
        test.stopTest();
    }
    

}