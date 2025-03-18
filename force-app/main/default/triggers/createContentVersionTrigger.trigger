trigger createContentVersionTrigger on ContentVersion (after insert) 
{
    List<ContentVersion> contentVersionList = trigger.new;
    if(trigger.isAfter && trigger.isInsert)
    {
        ContentVersionTrggerHandler.afterInsertContentVersion(contentVersionList);

    }

    

}