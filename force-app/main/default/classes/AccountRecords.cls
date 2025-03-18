public class AccountRecords {
    public List<Account> actList{get;set;}
    public AccountRecords(Apexpages.StandardController stdController)
    {
        actList = new List<Account>();
        actList = [select id,name,type,rating,phone from account limit 10];
    }
}