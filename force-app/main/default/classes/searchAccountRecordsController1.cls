public class searchAccountRecordsController1 
{
    public string searchText {get;set;}
    public List<Account> actList {get;set;}
    public void searchAccountRecords()
    {
        actList = new List<Account>();
         if(searchText != '' && searchText != null)
        {
            system.debug('searchText: ' + searchText);
            actList = [select id,name,Active__c,  Rating, Service_Tax__c, Phone, AnnualRevenue  from account where name like:searchText + '%' ];
            ApexPages.addMessage(New ApexPages.Message(ApexPages.Severity.CONFIRM,'opertaion has been successfully completed'));
            system.debug('actList: ' + actList);
        }
        else
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING,'please enter search text'));
            system.debug('search tex is empty: ' + searchText);
            
        }
        
    }
   

}