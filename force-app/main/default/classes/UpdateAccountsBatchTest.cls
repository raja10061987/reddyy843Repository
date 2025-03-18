@isTest
public class UpdateAccountsBatchTest 
{
    public static testMethod void updateAccountsTest()
    {
        List<account> actList = new List<Account>();
        // create account records
        for(integer counter = 1;counter<=10;counter++){
        Account actObj = new Account();
        actObj.Name = 'raja- ' + counter;
        actObj.Phone = '999999999';
        actObj.Fax = '888888888888';
        actObj.Rating = 'warm';
         actList.add(actObj);
            
        }
        system.debug('actList: ' + actList);
        if(!actList.isEmpty() && actList.size() > 0)
        {
            insert actList;
        }
        UpdateAccountsBatch batchObj = new UpdateAccountsBatch();
        test.startTest();
        Id batchJobId = database.executeBatch(batchObj);
        test.stopTest();
        system.debug('batchJobId: ' + batchjobId);
        
        
    }

}