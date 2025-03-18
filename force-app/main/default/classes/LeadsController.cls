public with sharing class LeadsController 
{

    @AuraEnabled(cacheable=true)
    public static Map<String,Integer> retriveLeads()
    {
        Map<String,Integer> leadsMap = new Map<String,Integer>();

        for(AggregateResult aggregateObj: [select count(id) leadCount,Status lStatus from Lead group by Status  ])
        {
            leadsMap.put((String)aggregateObj.get('lStatus'),(integer)aggregateObj.get('leadCount'));
        }
        system.debug('leadsMap: ' + leadsMap); // ({open-notcontacted=2,working-contacted-2})
        return leadsMap;
    }
   
}