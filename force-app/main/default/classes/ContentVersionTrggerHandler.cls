public with sharing class ContentVersionTrggerHandler {
   
   public static void afterInsertContentVersion(List<ContentVersion> contentVersionList)
   {
    system.debug('contentVersionList: ' + contentVersionList);
    List<File_Message_Event__e> messagesList = new List<File_Message_Event__e>();

    for(ContentVersion versionObj:contentVersionList)
    {
        File_Message_Event__e messageObj = new File_Message_Event__e();
        messageObj.Title__c = versionObj.Title;
        messageObj.case__c = '';
        messageObj.contentDocumentId__c = versionObj.ContentDocumentId;
        messageObj.ContentVersionId__c = versionObj.Id;
        messageObj.File_Extension__c = versionObj.FileExtension;
        messageObj.KYC_Status__c = 'submitted for verification';
        messageObj.LinkedEntityId__c = versionObj.FirstPublishLocationId; // accountId
        messagesList.add(messageObj);
    }
    system.debug('messagesList: ' + messagesList);
    if(!messagesList.isEmpty())
    {
      List<Database.saveResult> results = EventBus.publish(messagesList);
      system.debug('results: ' + results);
      for(Database.saveResult result: results)
      {
        if(result.isSuccess())
        {
            system.debug('platform event published successfully');

        }
        else
        {
            for(Database.Error error: result.getErrors())
            {
                system.debug('status code: ' + error.getStatusCode());
                system.debug('error message: ' + error.getMessage());

            }

        }

      }


    }

   }
}