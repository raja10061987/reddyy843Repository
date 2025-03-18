public class LeadContactWrapper 
{
    public id recordId {get;set;}
    public string fName {get;set;}
    public string lName {get;set;}
    public string name {get;set;}
    public string emailId {get;set;}
    public string contactNumber {get;set;}
    public string faxNumber {get;set;}
    public string isLeadContactRecord {get;set;}
    public boolean isSelected {get;set;}
    
    public LeadContactWrapper(Lead leadRecord,boolean ischecked)
    {
       recordId = leadRecord.id;
       fName = leadRecord.FirstName;
       lName = leadRecord.LastName;
       name = leadRecord.Name;
       emailId = leadRecord.Email;
       this.contactNumber = leadRecord.Phone;
       this.faxNumber = leadRecord.Fax;  
       this.isLeadContactRecord = 'Lead Record';
        this.isSelected = ischecked;	
    }
    
     public LeadContactWrapper(contact contactRecord, boolean ischecked)
    {
       // system.debug('contactRecord: ' + contactRecord);
       recordId = contactRecord.id;
       fName = contactRecord.FirstName;
       lName = contactRecord.LastName;
       name = contactRecord.Name;
       emailId = contactRecord.Email;
       this.contactNumber = contactRecord.Phone;
       this.faxNumber = contactRecord.Fax;  
       this.isLeadContactRecord = 'contact Record';
        this.isSelected = ischecked;
    }
    
}