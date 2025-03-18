public class ActionpollerLeadController {
    public List<Lead> leadList {get;set;}
    
    public void getLeadRecords()
    {
        leadList = new List<lead>();
        leadList = [select id,FirstName, LastName,name,email,phone,fax,IsConverted from lead where isConverted= false];
        system.debug('leadList size: ' + leadList.size());
        system.debug('leadList : ' + leadList);
        
    }
}