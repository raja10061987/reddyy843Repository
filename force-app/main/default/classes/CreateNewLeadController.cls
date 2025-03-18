public class CreateNewLeadController 
{
    public string leadRecordStatus{get;set;}
    public void CreateNewLead()
    {
        Lead leadRecord = new Lead();
        leadRecord.Salutation = 'Mr';
        leadRecord.FirstName = 'arjun1';
        leadRecord.LastName = 'kumar1';
        leadRecord.Company = 'infosys1';
        leadRecord.Status = 'Open - Not Contacted';
        leadRecord.Rating = 'Hot';
        leadRecord.NumberOfEmployees = 100;
        
        insert leadRecord;
        if(leadRecord.Id != null)
        {
            system.debug('Lead record is successfully with id: ' + leadRecord.Id);
            this.leadRecordStatus = 'Lead record is successfully with id: ' + leadRecord.Id;
        }
    }
}