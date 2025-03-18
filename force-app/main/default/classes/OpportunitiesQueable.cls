public class OpportunitiesQueable implements Queueable
{
    public Account actRecord;
    public OpportunitiesQueable(account act,ApexPages.StandardSetController controller)
    {
        this.actRecord = act;
    }
    public void execute(QueueableContext qContext)
    {
        Opportunity obj = new Opportunity();
        obj.Name = 'lankaramanopportunity';
        obj.CloseDate = system.today() + 10;
        obj.StageName = 'Prospecting';
        obj.Type = 'New Customer';
        obj.AccountId = actRecord.id;
        insert obj;
        if(obj.id != null)
        {
            system.debug('opportunity record created successfully');
        }
        
    }

}