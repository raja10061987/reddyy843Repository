public class CustomWrapperController 
{
    public List<LeadContactWrapper> lstWrappr {get;set;}
    
    public void getData()
    {
        lstWrappr = new List<LeadContactWrapper>();
        // get the lead records
        List<lead> leadList = [select id,FirstName, LastName,name,email,phone,fax,IsConverted from lead 
                               where IsConverted= false limit 2];
        // system.debug('leadList size: ' + leadList.size());
        // system.debug('leadList: ' + leadList);
        if(!leadList.isEmpty())
        { 
            for(Lead leadRecord:leadList)
            {
                LeadContactWrapper leadewrapper = new LeadContactWrapper(leadRecord,false);
              //  system.debug('leadewrapper: ' + leadewrapper);
                 lstWrappr.add(leadewrapper);
            } 
        }
        
        // get the contact records
        List<contact> contList = [select id,FirstName, LastName,name,email,phone,fax from contact limit 2];
       //  system.debug('contList size: ' + contList.size());
        // system.debug('contList: ' + contList);
        
        if(!contList.isEmpty())
        {
          for(Contact conObj:contList)
          {
              LeadContactWrapper contactWrapper = new LeadContactWrapper(conObj,false);
              // system.debug('contactWrapper: ' + contactWrapper);
              lstWrappr.add(contactWrapper);
          }
        }
        system.debug('lstWrappr size: ' + lstWrappr.size());
        system.debug('lstWrappr : ' + lstWrappr);
        
        
        
    }
    
    public void selectAllRecords()
    {
        if(!lstWrappr.isEmpty())
        {
            for(LeadContactWrapper wr: lstWrappr)
            {
                wr.isSelected = true;
            }
            system.debug('selected records: ' + lstWrappr);
        }
    }
    public void deselectAllRecords()
    {
        if(!lstWrappr.isEmpty())
        {
            for(LeadContactWrapper wr: lstWrappr)
            {
                wr.isSelected = false;
            }
            system.debug('deselected records: ' + lstWrappr);
        }
    }
    
    public void deleteselectedRecords()
    {
        if(!lstWrappr.isEmpty())
        {
            List<Id> toBeDeleteRecords = new List<Id>();
            for(LeadContactWrapper wr:lstWrappr)
            {
                if(wr.isSelected == true)
                {
                 toBeDeleteRecords.add(wr.recordId);   
                }
                
            }
             if(!toBeDeleteRecords.isEmpty())
             {
                 Database.delete(toBeDeleteRecords);
             }
            getData();
        }
    }

}