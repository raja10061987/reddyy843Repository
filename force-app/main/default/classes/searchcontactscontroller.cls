public class searchcontactscontroller 
{
    public transient  List<contact>  contList {get;set;}
    public  string  searchText {get;set;}
    public  string  nosearchText {get;set;}
    public static string mystring = 'hellow static string';
    
    public void getsearchContacts()
    {
        if(searchText != null && searchText != '')
        {
            nosearchText = '';
        contList = [select id,name,firstName,lastname,email,phone,fax from contact where name like:searchText + '%'];
        system.debug('contList size: ' + contList.size());
        system.debug('contList: ' + contList); 
        }
        else
        {
            contList = new List<contact>();
            nosearchText = 'please enter the contact  Name';
            system.debug('nosearchText: ' + nosearchText);
        }
       
    }

}