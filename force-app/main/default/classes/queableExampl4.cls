public class queableExampl4 implements queueable {

    public void execute(queueableContext qc){
        List<Account> accList = [select id,name from account limit 1];
        delete accList;
    }
}