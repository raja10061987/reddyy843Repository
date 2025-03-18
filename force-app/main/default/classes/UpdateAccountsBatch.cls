public with sharing class UpdateAccountsBatch implements Database.Batchable<sObject>,Database.StateFul,Database.AllowsCallouts,Database.raisesplatformEvents
{

    List<string> failedAccountIds = new List<string>();
    List<string> failedrecordMessages = new List<string>(); // ()
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        system.debug('start method called');
        string query = 'select Id,Name,Rating,Industry, CreatedDate from Account limit 3';
        return Database.getQueryLocator(query);

    }
    public void execute(Database.BatchableContext bc,List<Account> records)
    {
        system.debug('execute method called');
        for(Account actObj: records)
        {
            actObj.Name = null;

        }

        Database.SaveResult[] result = Database.update(records,false);
        system.debug('result: ' + result); // (DataBase.SaveResult:[getErrors=();getId=001ahgsha;isScccess=true],DataBase.SaveResult:[getErrors=(Database.error(getFields=(Name);getMessage=;getStatusCode=));getId=001ahgsha99;isScccess=false])
        
        for(DataBase.SaveResult str: result)
        {
            if(str.isSuccess())
            {
                system.debug('Account record updated successfully with id: ' + str.getId());

            }
            for(DataBase.error errorObj: str.getErrors())
            {
                string failedRecordId = str.getId();
                system.debug('update failed account record: ' + failedRecordId);
                system.debug('error message: ' + errorObj.getMessage());
                system.debug('error fields: ' + errorObj.getFields());
                
                failedAccountIds.add(failedRecordId);
                failedrecordMessages.add(errorObj.getMessage());

            }

        }
        

    }

    public void finish(Database.BatchableContext bc)
    {
        system.debug('finish method called');
        system.debug('failedAccountIds: ' + failedAccountIds); // (001hsad,001asna,001asjh)
        system.debug('failedrecordMessages: ' + failedrecordMessages);
        AsyncApexJob apexJobObj = [select Id,JobType, Status,TotalJobItems,JobItemsProcessed,NumberOfErrors,CompletedDate,ApexClass.Name,CreatedBy.Email,CreatedBy.Name,ExtendedStatus from AsyncApexJob where Id=:bc.getJobId()];
          system.debug('apexJobObj Batch: ' + apexJobObj); // AsyncApexJob: {Id=707,JobType=Batch,TotalJobItems=2}


         MessagingUtility.sendEmailFailedRecords(failedAccountIds,failedrecordMessages);
         MessagingUtility.sendEmailWithJobDetails(apexJobObj);
        system.debug('finish method ended');


    }
    
}