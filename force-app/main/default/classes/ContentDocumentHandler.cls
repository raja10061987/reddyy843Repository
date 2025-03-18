public with sharing class ContentDocumentHandler {
    public static void calculateFileContAfterDelete(List<ContentDocument> contDocList)
    {
        set<Id> contentIdsSet = new set<Id>();
        set<Id> actsIdsSet = new set<Id>();
        Map<Id,Account> actListMap = new Map<Id,Account>();

        for(ContentDocument conentObj: contDocList)
        {
            contentIdsSet.add(conentObj.Id);

        }
        System.debug('contentIdsSet: ' + contentIdsSet); // {0695g00000KfyTiAAJ}
        
       List<ContentDocumentLink> contentDocLinkList = [select Id,LinkedEntityId  from ContentDocumentLink  where ContentDocumentId in:contentIdsSet];
       system.debug('contentDocLinkList: ' + contentDocLinkList);

            for(ContentDocumentLink contLinkObj:[select Id,LinkedEntityId,ContentDocumentId  from ContentDocumentLink  where ContentDocumentId in:contentIdsSet] )
            {
                system.debug('contLinkObj: ' + contLinkObj);
                if(contLinkObj.LinkedEntityId != null && String.valueof(contLinkObj.LinkedEntityId).startsWithIgnoreCase('001'))
                {
                    actsIdsSet.add(contLinkObj.LinkedEntityId);

                }
            }


        if(actsIdsSet != null && actsIdsSet.size() > 0)
        {
            List<Account> actsList = [select Id,mytotalFileCount__c,(select Id from ContentDocumentLinks) from Account where Id in:actsIdsSet WITH SECURITY_ENFORCED];

            for(Account actObj:actsList)
            {
                actObj.mytotalFileCount__c = actObj.ContentDocumentLinks.size();
                actListMap.put(actObj.Id,actObj);               

            }
            system.debug('actListMap: ' + actListMap); // {001111csc = Account: {Id=001111csc,total_file_count__c=2}}
        }

        if(actListMap.values().size() > 0)
        {
            update  actListMap.values();

        }
    }
}