public with sharing class TriggerDispatcher 
{

    public static void run(ITriggerInterface handler,system.triggerOperation operationType)
    {
        if(handler.isdisabled())
        {
            return;

        }
        system.debug('operationType: ' + operationType);

        switch on operationType
        {
            when BEFORE_INSERT
            {
                system.debug('before insert called');
            }
            when AFTER_INSERT   
            {
                system.debug('after insert called');
                handler.afterInsert(trigger.newMap);
            }
            when BEFORE_UPDATE
            {
                system.debug('before update called');
            }
            when AFTER_UPDATE
            {
                system.debug('after update called');
                handler.afterUpdate(trigger.newMap,trigger.oldMap);
            }

        }


    }
    
}