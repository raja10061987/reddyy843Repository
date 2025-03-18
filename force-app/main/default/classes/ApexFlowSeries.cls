public with sharing class ApexFlowSeries {
    
    @InvocableMethod(Label='delete Opportunities' description='delete opportunities' category = 'Account')
    public static void deleteOpportunities(List<String> actIds)
    {
        System.debug('actIds: ' + actIds);
        List<Opportunity> optList = [select Name, StageName,AccountId from Opportunity where AccountId IN: actIds and StageName = 'Closed Won' WITH SECURITY_ENFORCED];
        System.debug('optList: ' + optList); // (Opportunity: {Id=003rfne,Name=suman},Opportunity: {Id=003rfne,Name=suman1})
        delete as user optList;

    }
}