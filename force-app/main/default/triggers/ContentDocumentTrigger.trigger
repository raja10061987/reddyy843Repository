trigger ContentDocumentTrigger on ContentDocument (before insert,after delete)
{
    if(trigger.isAfter && trigger.isDelete)
    {
        ContentDocumentHandler.calculateFileContAfterDelete(trigger.old);

    }

}