public class ShowAllContactsController 
{
    public List<Contact> contList {get;set;}
    
    public ShowAllContactsController()
    {
         contList = new List<Contact>();
        contList = [select name,LastName,FirstName from contact where firstName != '' limit 10];
        system.debug('contList: ' + contList);
    }
    

}