public class HiringManagerExtension {
     public Hiring_manager__c hrRecord;

    public HiringManagerExtension(ApexPages.StandardController controller) 
    {
        hrRecord = (Hiring_manager__C)controller.getRecord();
         system.debug('hrRecord1: ' + hrRecord);
       
    }
   
    public void CheckDuplicateHRRcords()
    {
         system.debug('hrRecord2: ' + hrRecord);
        integer hrCount = [select count() from hiring_manager__c where name=:hrRecord.Name and email_id__c=:hrRecord.Email_Id__c  and contact_number__c=:hrRecord.Contact_Number__c];
        system.debug('hrCount: ' + hrCount);
        if(hrCount > 0)
        {
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'duplicate records found. record cannot be inserted')) ;
        }
        else
        {
            insert hrRecord;
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM,'Record is inserted successfully:' ));
        }
        
    }

}