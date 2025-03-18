trigger OpportunityTriggerDemo on Opportunity (before insert,after insert,before update,after update) 
{
    System.triggerOperation operationType = trigger.operationType;
    system.debug('operationType: ' + operationType);
    TriggerDispatcher.run(new OpportunityTriggerHandler(),trigger.operationType);
}