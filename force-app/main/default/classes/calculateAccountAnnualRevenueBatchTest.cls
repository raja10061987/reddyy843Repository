@isTest
public class calculateAccountAnnualRevenueBatchTest
{
    public static testMethod void testAccountTotalRevenue()
    {
        List<Account> actList = new List<Account>();
        for(integer counter = 1;counter <=200; counter++)
        {
            account actObj = new Account();
            actObj.Name = 'raja- ' + counter;
            actObj.Active__c = 'yes';
            actObj.AnnualRevenue = 2000 + counter;
            actObj.BillingCity = 'Hyderabad';
            actObj.Rating = 'Hot';
              actList.add(actObj);
        }
        if(!actList.isempty() && actList.size() > 0)
        {
            insert actList;
            system.debug('actList: ' + actList);
            
        }
        
        calculateAccountAnnualRevenueBatch obj = new calculateAccountAnnualRevenueBatch();
        test.startTest();
        id jobId = database.executeBatch(obj);
        test.stopTest();
        system.debug('anonymous job id: ' + jobId);
    }

}