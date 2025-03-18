public with sharing class OpportunityTriggerHandler implements ITriggerInterface
{
    public static boolean  isTriggerDisabled = false;
    public boolean isdisabled()
    {
        return isTriggerDisabled;

    }

    public void afterInsert(Map<Id,sObject> newMap)
    {
        List<Opportunity> closedoptList = new List<Opportunity>();

        for(Opportunity optObj: (List<Opportunity>)newMap.values())
        {
            if(optObj.stageName == 'Closed Won')
            {
                closedoptList.add(optObj);

            }

        }
        if(closedoptList.size() > 0)
        {
            TasksService tskObj = new TasksService();
            tskObj.createTasks(closedoptList);

        }

    }

    public void afterUpdate(Map<Id,sObject> newMap,Map<Id,sObject> oldMap)
    {
        List<Opportunity> closedoptList = new List<Opportunity>();

        for(Opportunity newoptRecord: (List<Opportunity>)newMap.values())
        {
            Opportunity oldOptRecord = (Opportunity)oldMap.get(newoptRecord.Id);
            system.debug('oldOptRecord: ' + oldOptRecord);
            system.debug('newoptRecord: ' + newoptRecord);
            if(oldOptRecord.stageName != newoptRecord.stageName && newoptRecord.stageName == 'Closed Won')
            {
                closedoptList.add(newoptRecord);
            }
          

        }
        if(!closedoptList.isEmpty())
        {
            new TasksService().createTasks(closedoptList);

        }


    }
   
}