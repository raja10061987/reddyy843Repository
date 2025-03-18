public class searchLeadRecordsController 
{
    public List<lead> leadList {get;set;}
    public string searchText {get;set;}
    public string noText {get;set;}
    
    public void searchLeadRecordsByLastName()
    {
        noText = '';
        if(searchText != '' && searchText != null)
        {
            searchText = searchText + '%';
            system.debug('searchText: ' + searchText);
        leadList = [select id,name,firstName,LastName,email,phone,fax from lead where lastName like: searchText];
        system.debug('leadList size: ' + leadList.size());
        system.debug('leadList: ' + leadList);
        }
        else
        {
            leadList = new List<lead>();
            noText = 'please enter the lead name';
            
            
        }
        
    }
    

}