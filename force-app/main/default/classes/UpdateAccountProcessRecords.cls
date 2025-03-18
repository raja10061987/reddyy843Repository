Public with sharing class UpdateAccountProcessRecords implements Database.Batchable<sObject>,schedulable,Database.stateFul,Database.allowsCallouts
{

    public integer accountNumber = 10;
    public System.Iterable<Account> start (Database.BatchableContext bc)
    {
        String query = 'select Id,Name,AccountNumber from Account';
        return (List<Account>)Database.query(query);
    }

    public void execute(Database.BatchableContext bc,List<Account> records)
    {

        for(Account acc : records)
        {
            acc.AccountNumber = String.valueOf(accountNumber);
        }
        accountNumber = accountNumber + 1;
        update records;

    }
    public void execute(SchedulableContext sc)
    {
        UpdateAccountProcessRecords obj = new UpdateAccountProcessRecords();
        Id batchId = Database.executeBatch(obj,1);
    }

    public void finish(Database.BatchableContext bc)
    {
        // sending email
        // calling batch job again
        // calling queable batch
        System.debug('final finish method called');
        UpdateAccountProcessRecords obj = new UpdateAccountProcessRecords();
        Id jobId = Database.executeBatch(obj,1); // 4 junks  50 50 50 6  ==> 156
          system.debug('jobId: ' + jobId);


    }
    
    
}