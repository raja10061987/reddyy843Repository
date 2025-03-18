public class SearchAccountRecordsController 
{
    public transient List<Account> actList {get;set;}
    public transient string searchstring {get;set;}
    
    public SearchAccountRecordsController()
    {
     List<account>  actList = new List<Account>();  
    }
    public void searchRecords()
    {
        system.debug('searchstring: '  + searchstring);
        
        if(searchstring != '' && searchstring != 'null')
        {
        actList = [SELECT Id, Name, Type, Phone, Fax, AnnualRevenue, Industry, Rating FROM Account 
                   where name like:searchstring + '%'];
        system.debug('actList size: ' + actList.size());
        system.debug('actList: ' + actList);
        system.debug('inside if block');
        ApexPages.addMessage( New ApexPages.message(ApexPages.Severity.CONFIRM,'process successfully completed'));
        }
        else
        {
         system.debug('inside else block');  
         ApexPages.addMessage(New ApexPages.message(ApexPages.Severity.ERROR,'Please Enter the account Name'));
           
        }
      
    }

}