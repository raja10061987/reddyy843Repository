global class calculateAccountAnnualRevenueBatch implements Database.Batchable<sObject>,database.stateful
{
      global decimal totalAnnualRevenue = 0;
     global database.QueryLocator start(Database.BatchableContext bc)
    {
        system.debug('start method');
        string query = 'select id,name,annualrevenue,rating from account where annualRevenue != null';
       return Database.getQueryLocator(query);
    }
    // total: 10 batch size: 5
    // batch1            batch2
    // 1-5                 5-10
     global void execute(Database.BatchableContext bc,List<Account> recordstoProcess)
    {
        system.debug('execute method');
        if(!recordstoProcess.isEmpty() && recordstoProcess.size() > 0)
        {
            for(Account actObjerecord: recordstoProcess)
            {
                //  Account actObj = (Account)sObjectRecord;
                totalAnnualRevenue += actObjerecord.AnnualRevenue;
            }
            
        }
        
    }
     global void finish(Database.BatchableContext bc)
    {
        system.debug('finish method');
        asyncapexjob jobdetails = [select id,jobType,status,totaljobitems,jobitemsprocessed,numberoferrors,createdby.email
                                   from asyncapexjob where id=:bc.getJobId()];
        system.debug('job details: ' + jobdetails);
        system.debug('total annual revenue: ' + totalAnnualRevenue);
        // send email notification to the user
         MessagingUtility.sendtotalAnnualRevenueNotification(jobdetails, 'calculate total annual revenue', totalAnnualRevenue);
    }

}