trigger ContactDetailsValidationTrigger on Contact (before insert,after insert,before update,before delete) 
{
    system.debug('trigger.isBefore: ' + trigger.isBefore);
        system.debug('trigger.isUpdate: ' + trigger.isUpdate);
         system.debug('trigger.isInsert: ' + trigger.isInsert);
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
    {
        
      
       // ContactsDetailsValidation.ContactsPhoneEmailValidation(trigger.New);
       // ContactsDetailsValidation.MakesureContactsAssosiatedWithAccounts(trigger.New);
        
    }

    if(trigger.isAfter && trigger.isInsert && !ContactTriggerHandler.isTriggerRan)
    {
        ContactTriggerHandler.isTriggerRan = true;
        ContactTriggerHandler.recursiveTrigger(Trigger.New);

    }
   

}