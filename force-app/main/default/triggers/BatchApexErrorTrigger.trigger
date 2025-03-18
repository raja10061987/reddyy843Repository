trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) 
{
    if(trigger.isAfter && trigger.isInsert)
    {
        BatchApexHnadler.afterInsert(trigger.New);

    }

}