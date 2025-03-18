trigger updateRecruiterToHiringManager on Recruiter__c (after update) 
{
    
    
   if(trigger.isAfter && trigger.isUpdate && triggerGlobalVariable.firstRun)
   {
       triggerGlobalVariable.firstRun = false;
       system.debug('recRecord: trigge.New: ' + trigger.New);
       system.debug('trigger.newMap: ' + trigger.NewMap);
       system.debug('trigg.old: ' + trigger.old);
       system.debug('trigger.oldmap: ' + trigger.oldMap);
       
       // List<Recruiter__c> recRecords = trigger.New;
       HiringManager.AutoUpdateRecruiterToHiringManager(trigger.New,trigger.oldMap);
        
           
   }
}