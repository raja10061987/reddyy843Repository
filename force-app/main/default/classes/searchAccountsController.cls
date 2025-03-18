public class searchAccountsController 
{
    public string searchText {get;set;}
    public List<Account> actList {get;set;}
    public string searcherror {get;set;}
   
    public void serachAccounts()
    {
        system.debug('searchText: ' + searchText + '%');
        actList = new List<Account>();
        searcherror= '';
        if(searchText != '')
        {
         
        actList = [select id,name,fax,website,AccountNumber, type,industry,rating,phone from account where name like: searchText + '%'];
        system.debug('actList size: ' + actList.size());
        system.debug('actList: ' + actList);
            if(actList.size() == 0)
            {
                searcherror = 'no records present for the available searchtext';
            }
            
        }
        else
        {
            system.debug('please provide the searchtext');
            searcherror = 'please provide the searchtext';
        }
      
        
    }

}