public class ShowAllAccountsController 
{
    public   List<Account> actList {get;set;}
    public ShowAllAccountsController()
    {
     actList = new List<Account>();
    
    }
   public void getAllAccounts()
   {
 
    actList = [SELECT Id, Name, Type, BillingStreet, BillingCountry, Phone, Website, Industry, AnnualRevenue, Rating FROM Account order by Name];
    system.debug('actList: ' + actList);
   
   }
}