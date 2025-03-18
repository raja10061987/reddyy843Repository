public class QueableExample5 implements queueable
{
    public void Execute(queueableContext QC){
        queableExampl4 qe4 = new queableExampl4();
        Id jobId = system.enqueueJob(qe4);
        List<Contact> contacts = [select id,name from Contact limit 1];
        delete contacts;
        
    }

}