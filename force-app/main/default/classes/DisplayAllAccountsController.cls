public with sharing  class DisplayAllAccountsController 
{
    public List<Account> actList {get;set;}
    public DisplayAllAccountsController()
    {
        actList = new List<Account>();
        actList = [SELECT Id, Name, Type, ShippingAddress, Phone, Fax, AccountNumber, Industry, AnnualRevenue, NumberOfEmployees, Rating FROM Account];
        system.debug('actList size: ' + actList.size());
        system.debug('actList: ' + actList);
        
    }
}