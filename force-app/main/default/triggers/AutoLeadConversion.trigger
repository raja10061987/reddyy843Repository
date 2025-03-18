trigger AutoLeadConversion on Lead (after update,after insert,before insert) 
{
    if(trigger.isAfter && trigger.isUpdate)
    {
       boolean isAfter = trigger.isAfter;
       boolean isUpdate = trigger.isUpdate;
        system.debug('isAfter: ' + isAfter);
        system.debug('isUpdate: ' + isUpdate);
       AutoLeadConversionAfterUpdate.LeadConversionAfterUpdate(trigger.New);      
        
  }

  if(trigger.isBefore && trigger.isInsert)
  {
    LeadTriggerHandler.InsertCaseAfterInsert(trigger.New);

  }

}