public with sharing class ReParent_Batch implements Database.batchable<sObject>,Database.stateful
{

    public Database.queryLocator start(Database.batchableContext bc)
    {
        String query = 'select Id,Name,AccountNumber from Account';
        System.debug('start method called');
        return Database.getQueryLocator(query);

    }

    public void execute(Database.batchableContext bc,List<Account> records)
    {
        System.debug('execute method called');

    }
    public void finish(Database.BatchableContext bc)
    {
        System.debug('finsh method called');
        // ExportChargesToERPQueable job = new ExportChargesToERPQueable();
 
        // Id jobId =System.enqueueJob(job);
        // System.debug(' ExportChargesToERPQueable jobId: ' + jobId);

        
//    RecalCommissin_Queable job1 = new RecalCommissin_Queable();
 
//           Id recaljobId =System.enqueueJob(job1);
//          System.debug('recaljobId: ' + recaljobId);

         // System.LimitException: Too many queueable jobs added to the queue: 2
         // overcome problem by using platfot events, these events will run seperate context

         List<Account_Creation_Event__e> eventList = new List<Account_Creation_Event__e>();
         Account_Creation_Event__e event = new Account_Creation_Event__e();
         event.Class_Name__c = 'ExportChargesToERPQueable';
         event.Error_Description__c	= 'evnt fired from batch';
         event.Batch_Size__c = 100;

         Account_Creation_Event__e event1 = new Account_Creation_Event__e();
         event1.Class_Name__c = 'RecalCommissin_Queable';
         event1.Error_Description__c	= 'evnt fired from batch';
         event1.Batch_Size__c = 100;
         eventList.add(event);
         eventList.add(event1); // (Account_Creation_Event__e: {Name=,Error_Description__c =},)
         List<Database.saveResult> resultList;
         if(eventList.size() > 0)
         {
             resultList = EventBus.publish(eventList);
            system.debug('resultList:' + resultList); // (Database.SaveResult: {Database.Errors: (),})
         }
        

      

        for (Database.saveResult result : resultList) {
            if(result.isSuccess())
            {
                System.debug('platform event published successfully ');

            }
            else {
                for (Database.Error errorObj : result.getErrors()) {
                    System.debug('error Code: ' + errorObj.getStatusCode());
                    System.debug('error message: ' + errorObj.getMessage());
                    System.debug('Fields: ' + errorObj.getFields());
                    
                }
            }
            
        }
     

    }
    
}