public class AutoLeadConversionAfterUpdate 
{
      public static void LeadConversionAfterUpdate(List<Lead> leadList)
      {
          system.debug('inside method');
          LeadStatus leadstatus = [SELECT Id, MasterLabel, IsConverted FROM LeadStatus where IsConverted=true];
          List<Account> actRecords = [SELECT Id, Name FROM Account where name= 'raja1account' limit 1];
          List<Database.LeadConvert> lstConverted = new List<Database.LeadConvert>();
          for(Lead ld:leadList)
          {
              system.debug('lead status: ' + ld.Status);
              system.debug('is lead converted: ' + ld.IsConverted);
              if(ld.status == 'Closed - Converted' && ld.IsConverted == false)
              {  
                  system.debug('inside if block');
                  Database.LeadConvert ldConvert = new Database.LeadConvert();
                  ldConvert.setLeadId(ld.Id);
                  ldConvert.setSendNotificationEmail(true);
                  ldConvert.setDoNotCreateOpportunity(ld.Do_Not_Create_Opportunity__c);
                  ldConvert.setConvertedStatus(leadstatus.MasterLabel);
                  for(Account actRecord:actRecords)
                  {
                    ldConvert.setAccountId(actRecord.Id);
                  }
                  lstConverted.add(ldConvert);
                  system.debug('lstConverted@@: ' + lstConverted);
              }
              
          }
          system.debug('lstConveted size: ' + lstConverted.size());
          if(!lstConverted.isEmpty())
          {  
              try
             {
             Database.LeadConvertResult[] leadResult = Database.convertLead(lstConverted);
             }
              catch(exception ex)
              {
                  system.debug('getmessage: ' + ex.getMessage());
                  system.debug('stack trace: ' + ex.getStackTraceString());
                  system.debug('get cause: ' + ex.getCause());
              }
              
          }
          
      }
}