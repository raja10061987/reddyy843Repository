trigger subscribeplatforrmEvent on File_Message_Event__e (after insert) 
{
    system.debug('File_Message_Event__e subsribe called');
    List<File_Message_Event__e> myMessageList = trigger.new;
List<Document> docList = new List<Document>();
    if(trigger.isAfter && trigger.isInsert)
    {
        for(File_Message_Event__e Obj: myMessageList)
        {
           Document docObj = new Document();
           docObj.Name= Obj.Title__c;
          docObj.folderId = '0055g000005njrvAAA';
          docList.add(docObj);

        }
        if(docList.size() > 0)
        {
            insert as user docList;
            system.debug('docList: ' + docList);
            system.debug('document record inserted sussceefully');

        }

    }

}