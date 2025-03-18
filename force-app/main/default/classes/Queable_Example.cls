public class Queable_Example implements queueable{
    public void Execute(queueablecontext qc){
        List<Account> accounts = [select id from Account where createddate= this_month];
        delete accounts;
    }
}