Global class Batchable_example1 implements Database.Batchable<sObject> 
{
    global Database.QueryLocator start(Database.BatchableContext bc){
        string query = 'select id,name,type from opportunity'; //13
        return Database.getQueryLocator(query);
        
    }
    // Batch1       batch2
    // 1-10         12-13
    
    global void Execute(Database.BatchableContext bc, List<Opportunity> scope){
        for(Opportunity opp:scope){
            opp.Type = 'New Customer1';
        }
        update scope;
        system.debug('child jobId' + bc.getChildJobId() );
    }
    global void finish(Database.BatchableContext bc){
        asyncApexJob job = [select id,status,JobType from asyncApexJob where id=:bc.getJobId()];
         system.debug('status:' + job.status);        
    }
}