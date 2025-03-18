trigger ContentDocumentLinkTrigger on ContentDocumentLink (after insert) 
{
    if(trigger.isAfter && trigger.isInsert)
    {
        ContentDocumentLinkHandler.calculateTotalFilesAfterInsert(trigger.new);

    }

}