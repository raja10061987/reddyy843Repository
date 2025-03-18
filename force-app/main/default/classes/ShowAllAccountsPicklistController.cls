public class ShowAllAccountsPicklistController 
{
    public List<selectOption> lstOptions {get;set;}
    public List<contact> contList {get;set;}
    public string selectedAccountId {get;set;}
    public string iscontactsAvailable {get;set;}
    public ShowAllAccountsPicklistController()
    {
        lstOptions = new List<selectOption>();
        List<Account> actList = [select id,name from account order by name];
        system.debug('selectedAccountId: ' + selectedAccountId);
        if(!actList.isEmpty())
        {
            selectOption option = new selectOption('','--NONE--');
            lstOptions.add(option);
            for(Account actObj: actList)
            {
               selectOption opt = new selectOption(actObj.Id,actObj.Name);
               lstOptions.add(opt);
            }
            
            
        }
    }
    
    public void getRelatedContacts()
    {
        iscontactsAvailable = '';
        system.debug('selectedAccountId: ' + selectedAccountId);
        if(selectedAccountId != null && selectedAccountId !='')
        {
           contList = new List<Contact>();
           contList = [select id,name,FirstName, LastName, email,phone,fax from contact where AccountId =: selectedAccountId];
            system.debug('contList: ' + contList.size());
        }
        if(contList.size() == 0)
        {
            iscontactsAvailable = 'No related contacts availablle for the selected account: ' + selectedAccountId;
        }
        else
        {
            iscontactsAvailable = 'available contacts related to account: ' + selectedAccountId;
        }
    }
}