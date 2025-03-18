trigger HiringManagerTrigger on Hiring_Manager__c (before insert,before Update,after insert,after update, before delete) 
{
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate) && triggerGlobalVariable.firstRun)
    {
        HiringManager.checkDuplicateRecords(trigger.New);
          
        HiringManager.getAzureCredentials(trigger.New);
    }
    if(trigger.isAfter && trigger.isInsert)
    {
        HiringManager.AutosyncHiringManagerRecruiter(trigger.New);
        // sharing the records through apex sharing
        HiringManager.HiringManagerRecordsSharing(trigger.new);
    }
    
    if(trigger.isAfter && trigger.isUpdate)
    {
        HiringManager.AutoUpdateHiringManagerRecruiter(trigger.New,trigger.oldMap,trigger.newMap);
        HiringManager.shareHRRecordsAfterUpdate(trigger.New,trigger.oldMap,trigger.newMap);
        
    }
    if(trigger.isBefore && trigger.isDelete)
    {
       HiringManager.deleteAllRecuruitersRelatedtoHRRecords(trigger.oldMap.keyset());
        
    }
    
   

}