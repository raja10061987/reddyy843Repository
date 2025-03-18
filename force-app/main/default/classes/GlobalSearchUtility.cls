public class GlobalSearchUtility {

    public static void searchRecords()
    {
        List<List<sObject>> listRecords = [FIND 'pavan*' IN ALL FIELDS RETURNING
                                           Account(id,name,Rating,Industry),
                                           Case(id,casenumber,subject,status),
                                           Opportunity(Id,Name,Type,LeadSource)
                                          ];
        
        
        system.debug('listRecords: ' + listRecords);
        List<Account> actList = listRecords.get(0);
        List<Case> caseList = listRecords.get(1);
        List<Opportunity> optList = listRecords.get(2);
        system.debug('matching account List size: ' + actList.size());
        system.debug('matching case List size: ' + caseList.size());
        system.debug('macthing opportunity List size: ' + optList.size());
        for(Account actRecord:actList)
        {
            system.debug('matching account Record: ' + actRecord);
        }
        for(Case caseRecord:caseList)
        {
            system.debug('matching case Record: ' + caseRecord);
        }
        for(Opportunity optRecord:optList)
        {
            system.debug('opportunity record: ' + OPTRECORD);
        }
    }
    
    public static void dynamicSearchRecords(string searchText)
    {
        if(searchText != '' && searchText!= null)
        {
            system.debug('my searchText: ' + searchText);
             String globalSearchQuery = 'FIND '+ ' \' ' + searchText + '*'+ ' \' '+ ' IN ALL FIELDS RETURNING '+
                						'Account(id,name,Rating,Industry Limit 100),'+
                						'Case(id,casenumber,subject,status Limit 5),'+
                						'Opportunity(Id,Name,Type,LeadSource),'+
                						'Position__C(ID, name, location__C, position_status__C, milestone_Date__C, maximum_budget__C)';
                 
                 if(globalSearchQuery!= null)
                 {
             List<List<sObject>> searchResult = search.query(globalSearchQuery);
                  if(searchResult!= null)
                  {
              List<Account> actList = (List<Account>)searchResult.get(0);
            List<Case> caseList = (List<Case>)searchResult.get(1);
            List<Opportunity> optList = (List<Opportunity>)searchResult.get(2);
            List<Position__C> positionList = (List<Position__C>)searchResult.get(3);
            system.debug('actList Size: ' + actList.size());
            system.debug('caseList Size: ' + caseList.size());
            system.debug('optList Size: ' + optList.size());
            system.debug('positionList Size: ' + positionList.size());   
             for(Account actObj:actList)
            {
                system.debug('matching account record: ' + actObj);
            }
            for(Case caseObj: caseList)
            {
                system.debug('matching case Record: ' + caseObj);
            }
            for(opportunity optObj: optList)
            {
                system.debug('matching opportunity Record: ' + optObj);
            }
            for(position__C pObj: positionList)
            {
                system.debug('matching position Record: ' + pObj);
            }
                  }
             
                 }
        }
        
    }
}