public with sharing class AggregateResultController 
{
    public List<AggregateResult> aggregateResultList {get;set;}
    public AggregateResultController() 
    {
        aggregateResultList = new List<AggregateResult>();
        aggregateResultList = [select count(Id) leadCount,Status,sum(AnnualRevenue) totalAnnaulAmount from Lead  WITH SECURITY_ENFORCED group by status];
       // aggregateResultList = [select count(Id),Status,sum(AnnualRevenue) from Lead  WITH SECURITY_ENFORCED group by status];
        System.debug('aggregateResultList: ' + aggregateResultList);

    }
}