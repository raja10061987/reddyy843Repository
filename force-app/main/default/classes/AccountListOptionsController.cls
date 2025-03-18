public class AccountListOptionsController 
{
    public List<selectOption> optionList {get;set;}
    public string selectedaccountId {get;set;}
    public List<contact> contList {get;set;}
    public string isContactsAvailable {get;set;}
    public AccountListOptionsController()
    {
        optionList = new List<selectOption>();
        contList = new List<Contact>();
        List<account> actList = [select id,name from account];
        if(!actList.isEmpty())
        {
            selectOption optObj = new selectOption('--','--NONE---');
            optionList.add(optObj);
         for(account actObj: actList)
         {
             selectOption optObj1 = new selectOption(actObj.id,actObj.Name);
             optionList.add(optObj1);
         }
            system.debug('optionList: ' + optionList);
        }       
    }
    
    public void getRelatedContactsByAccountId()
    {
        system.debug('selectedaccountId: ' + selectedaccountId);
        if(selectedaccountId != null && selectedaccountId != '')
        {
            contList = [select id,name,FirstName, LastName, email,phone,fax from contact where AccountId =: selectedaccountId];
            system.debug('contList size: ' + contList.size());
            system.debug('contList: ' + contList);
        }
        if(contList.size() > 0)
        {
          isContactsAvailable = 'contacts available for selected account: ' + selectedaccountId;  
        }
        else
        {
            isContactsAvailable = ' No contacts  available for selected account: ' + selectedaccountId;
        }
    }
    

}