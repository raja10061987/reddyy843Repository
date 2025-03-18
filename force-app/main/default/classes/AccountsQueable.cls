public class AccountsQueable implements Queueable
{
    @TestVisible
    private static Boolean doChainJob = true;
    public void execute(QueueableContext qContext)
    {
        
        system.debug('Accounts queable job');
        Account actObj = new Account();
        actObj.Name = 'lankaraman123';
        actObj.Rating = 'Hot';
        actObj.Active__c = 'No';
        actObj.AnnualRevenue = 12000;
        actObj.AccountNumber = '123456';
        actObj.BillingCity = 'Hyderabad1';
        actObj.Phone = '7013948962';
        actObj.ShippingCity = 'Hyderabad';
        insert actObj;
        if(actObj.Id != null && doChainJob)
        {
            system.debug('account record created successfully: ' + actObj.Id);
            Id jobId = system.enqueueJob(new OpportunitiesQueable(actObj));
        }
        
    }

}