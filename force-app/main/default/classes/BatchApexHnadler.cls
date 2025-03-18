public with sharing class BatchApexHnadler {
    public static void afterInsert(List<BatchApexErrorEvent> batchApexEvent)
    {
        set<Id> apexJobIds = new set<Id>();

        for(BatchApexErrorEvent evt:batchApexEvent)
        {
            apexJobIds.add(evt.AsyncApexJobId);
        }
        System.debug('apexJobIds'+apexJobIds);
        Map<Id,AsyncApexJob> jobsMap = new Map<Id,AsyncApexJob>([SELECT Id, ApexClass.Name FROM AsyncApexJob WHERE Id IN :apexJobIds]);
        system.debug('jobsMap: ' + jobsMap);

         List<Btach_Retry_Event__c> errorList = new List<Btach_Retry_Event__c>();
        for(BatchApexErrorEvent evt:batchApexEvent)
        {
            AsyncApexJob job1 =  jobsMap.get(evt.AsyncApexJobId);
            if(job1.ApexClass.Name == 'UpdateAccountsBatch')
            {
                for(String recordId: evt.JobScope.split(','))
                {
                    Btach_Retry_Event__c errorObj = new Btach_Retry_Event__c();
                    errorObj.RecordIds__c	 = recordId;
                    errorObj.Error_Message__c  = evt.Message;
                    errorList.add(errorObj);

                }
               

            }
           
        }
       
        if(errorList.size() > 0)
        {
            system.debug('error records size: ' + errorList.size());
            system.debug('errorList: ' + errorList);
            try {
                insert errorList;
            } catch (Exception ex) 
            {
                system.debug('insert task failed: ' + ex.getmessage());
                
            }
            

        }

    }
}