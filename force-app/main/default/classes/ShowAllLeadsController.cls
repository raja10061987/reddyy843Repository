public class ShowAllLeadsController 
{
    public List<Lead> leadRecords {get;set;}
    public decimal count {get;set;}
    public ShowAllLeadsController()
    {
        count = 0;
    }
    public void getLeadRecords()
    {
        leadRecords = new List<Lead>();
        leadRecords = [Select id, firstname, lastname, title, email, phone, fax, company, status,rating, industry, annualrevenue, CreatedDate from Lead Order by CreatedDate desc];
        system.debug('leadRecords: ' + leadRecords);
        count = count + 1;
        
    }

}