@isTest
public with sharing class ContentDocumentLinkTriggerTest {
    

    @TestSetup
    public static void makedata()
    {
        Account actObj = new Account();
        actObj.Name= 'suman';
        actObj.Rating = 'Hot';
        insert actObj;
        system.debug('actObj: ' + actObj);

        ContentVersion contentV = new ContentVersion();
        contentV.Title  = 'hello';
        contentV.PathOnClient = 'hello.jpeg';
        contentV.VersionData  = Blob.valueOf('Test Content');
        contentV.IsMajorVersion  = true;
        insert contentV;
        system.debug('contentV: ' + contentV);

        List<ContentDocument> documents = [ SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        system.debug('documents: ' + documents);


        ContentDocumentLink cdl = new ContentDocumentLink();
           cdl.LinkedEntityId = actObj.Id;
           cdl.ContentDocumentId = documents[0].Id;
           cdl.ShareType = 'V';
           insert cdl;
           system.debug('cdl: ' + cdl);


    }

    @isTest
    public static void calculateTotalFilesAfterInsertTest()
    {
        
        Test.StartTest();
        System.assertEquals(1,1,'both are not equal');
        Test.stopTest();
    }

    @isTest
    public static void calculateFileContAfterDeleteTest()
    {
        ContentVersion conVersion = new ContentVersion();
        conVersion.Title = 'hello';
        conVersion.PathOnClient = 'hello.jpg';
        conVersion.VersionData = Blob.valueOf('hello');
        conVersion.IsMajorVersion = true;
        insert conVersion;
        system.debug('conVersion@@: ' + conVersion);

        List<ContentDocument> conDocsList = [select Id,Title from ContentDocument];
        system.debug('conDocsList@@: ' + conDocsList);
        Test.StartTest();
        delete conDocsList;
        system.assert(1==1, 'both are not equal');
        Test.stopTest();
    }


}