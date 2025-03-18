public class Queable_Example1 implements queueable
{
    public void execute(queueableContext qc){
        Queable_Example qe = new Queable_Example();
        Id jobId = system.enqueueJob(qe);
        List<Contact> contacts = [select id from contact where createdDate= this_month];
        delete contacts;
    }

}