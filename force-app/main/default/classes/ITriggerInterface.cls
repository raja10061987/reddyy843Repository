public  Interface ITriggerInterface 
{
    boolean isdisabled();
    void afterInsert(Map<Id,sObject> newMap);
    void afterUpdate(Map<Id,sObject> newMap,Map<Id,sObject> oldMap);

}