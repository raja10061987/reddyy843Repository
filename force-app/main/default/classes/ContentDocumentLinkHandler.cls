public with sharing class ContentDocumentLinkHandler {
   

    public static void calculateTotalFilesAfterInsert(List<ContentDocumentLink> contDocList)
    {
        set<Id> actIdSet = new set<Id>();
        Map<Id,Account> accountMap = new Map<Id,Account>();
        system.debug('actIdSet: ' + actIdSet);
        for(ContentDocumentLink conLinkObj: contDocList)
        {
            if(conLinkObj.LinkedEntityId != null && String.valueof(conLinkObj.LinkedEntityId).startsWithIgnoreCase('001'))
            { 
                actIdSet.add(conLinkObj.LinkedEntityId);
            }

        }
        system.debug('actIdSet: ' + actIdSet);

        if(actIdSet != null && actIdSet.size() > 0)
        {
        List<Account> actsList = [select Id,Total_File_Count__c,(select Id from ContentDocumentLinks) from Account where Id in:actIdSet];
          for(Account actObj:actsList)
          {
            actObj.total_file_count__c = actObj.ContentDocumentLinks.size();
            accountMap.put(actObj.Id,actObj); 

          }
          system.debug('accountMap: ' + accountMap);
          if(!accountMap.values().isEmpty())
          {
            try {
                update as user accountMap.values(); // ()
            } catch (Exception ex) {
                system.debug('exception:' + ex);
                System.debug('Error--'+ex.getMessage());

            }
           

          }

        }

    }
}