global class AnnualRevenueBatchScheduling implements system.Schedulable
{
    global void execute(system.SchedulableContext sc)
    {
        calculateAccountAnnualRevenueBatch obj = new calculateAccountAnnualRevenueBatch();
        Id jobId = Database.executeBatch(obj);
       
        
    }
        

}