public with sharing class UploadDoc_AC {
    
    public static void createContentVersion()
    {
        
Account actObj = new Account();
actObj.Name = 'myTest Account helo12';
actObj.Rating = 'Hot';
insert as user actObj;
system.debug('actObj: ' +actObj);

ContentVersion cVersion = new ContentVersion();
cVersion.ContentLocation = 'S';
cVersion.Title = 'Test Document hello super 123';
cVersion.pathOnClient = 'TestDocument.pdf';
cVersion.VersionData = Blob.valueOf('Test Document1');
cVersion.FirstPublishLocationId = actObj.Id;
cVersion.IsMajorVersion = true;

insert as user cVersion;
system.debug('cVersion: ' + cVersion); // 0685g00000NZFXbAAP

Id contentDocumentId = [select ContentDocumentId from ContentVersion where Id=:cVersion.Id WITH SECURITY_ENFORCED].ContentDocumentId;
system.debug('contentDocumentId: ' +  contentDocumentId);

List<ContentDocumentLink> contentLinkDoc = [select Id,ContentDocumentId, LinkedEntityId, LinkedEntity.Type from ContentDocumentLink where ContentDocumentId=:contentDocumentId];
system.debug('contentLinkDoc: ' + contentLinkDoc);
ContentDocument contentDocObj = [select Id,PublishStatus, LatestPublishedVersion.Title,LatestPublishedVersion.PathOnClient,ParentId from ContentDocument where Id=:contentDocumentId WITH SECURITY_ENFORCED];
 system.debug('contentDocObj: ' + contentDocObj);


    }
}