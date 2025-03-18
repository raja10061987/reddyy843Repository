public class CandidateHandler 
{
    
    public static void sendReminderNotificationToContacts()
    {
        Map<Id,contact> mapContacts = new Map<Id,Contact>(
            [select id,firstname,lastname,email,accountId from contact where accountId=null and email!= null]);
         system.debug('mapContatcts: ' + mapContacts);
        List<Id> contactIdList = new List<Id>();
        if(!mapContacts.isEmpty())
        {
            contactIdList.addAll(mapContacts.keyset());
            system.debug('contactidList: ' + contactidList);
        }
        if(!contactIdList.isEmpty())
        {
            Messaging.MassEmailMessage massEmail = new Messaging.MassEmailMessage();
            EmailTemplate Template = [select id,name,isActive from EmailTemplate where name = 'Contact Email template'];
            if(template.id != null && template.IsActive == true)
            {
                massEmail.setTargetObjectIds(contactIdList);
                massEmail.setTemplateId(Template.id);
                Messaging.sendEmail(new Messaging.MassEmailMessage[]{massEmail});
            }
            
           
            
        }
        
    }
    
    public static void sendEmailtoCandidates(List<Candidate__c> canList)
    {
        if(!canList.isEmpty() && canList.size() > 0)
        {
            List<Messaging.SingleEmailMessage> lstEmailstoCandidate = new  List<Messaging.SingleEmailMessage>();
            for(Candidate__c canRecord:canList)
            {
                Messaging.SingleEmailMessage email = new messaging.SingleEmailMessage();
                string[] toEmailIds = new string[]{canRecord.email_id__c,'reddyy843@gmail.com'};
                    system.debug('toEmailIds: ' + toEmailIds);
                    email.setToAddresses(toEmailIds);
                
                // string[] ccEmailIds = new string[]{canRecord.Email_id__c,'reddyy843@gmail.com'};
                   // email.setCcAddresses(ccEmailIds);
               // string[] bccEmailIds = new string[] {canRecord.Email_id__c,'reddyy843@gmail.com'};
                  //  email.bccaddresses(bccEmailIds);
                email.setSenderDisplayName('Candidate Record creation Notification alert');
                email.setReplyTo('reddyy843@gmail.com');
                
                string emailSubject = 'Congratulations ' + canRecord.Name + ' !!! your candidature has been successfully submitted for the position';
                email.setSubject(emailsubject);
                
                string emailHtmlContent = 'Dear' + canRecord.Name + ',<br/><br/>' +
                                            'Thanks for showing interest in our organisation positions.<br/><br/>' +
                                             'we are pleased to inform you,that your candidature has been successfully submitted for the position.' +
                                              canRecord.Position__c +
                                              '<br/><br/> here are your details: <br/><br/>' +
                                              'Candidate name: ' + canRecord.Name +
                                              '<br/> candidate emailId: ' + canRecord.Email_id__c +
                                              '<br/> candidate phone: ' + canRecord.Phone__c +
                                              '<br/> notice period: ' + canRecord.Notice_period__c +
                                              '<br/> experience ' + canRecord.Experience__c +
                                              '<br/> current CTC: ' + canRecord.current_CTC__c +
                                              '<br/> Expected CTC:' + canRecord.Expected_CTC__c;
                
                
                email.setHtmlBody(emailHtmlContent);
                lstEmailstoCandidate.add(email);
                system.debug('lstEmailstoCandidate: ' + lstEmailstoCandidate);
                
                    
            }
            
            // send Email Notification
           if(!lstEmailstoCandidate.isEmpty())
           {
               Messaging.sendEmail(lstEmailstoCandidate);
               
           }
            
        }
        
        
    }

}