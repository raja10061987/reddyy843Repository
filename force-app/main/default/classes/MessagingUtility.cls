public class MessagingUtility 
{
    public static void sendBatchJobNotification(asyncApexJob job,string jobName)
    {
        system.debug('email notification method:');
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        string[] toAddress = new string[]{job.CreatedBy.email,'reddyy843@gmail.com'};
            email.setToAddresses(toAddress);
        string emailSubject = 'Batch job:- ' + jobName + '--' + job.Id + 'Exection success notification';
        email.setSubject(emailSubject);
        email.setReplyTo('feroz@gmail.com');
        email.setSenderDisplayName('weekely batch job notification: ');
        
        string emailcontent = 'Dear customer.<br/><br/>' +
                               'here is the job status notification details: ' 
                                 +'<br/><br/> batch job Id: ' + job.Id
                                 +'<br/><br/> batchjob name: ' + jobname
                                 + '<br/><br/> job Type: ' + job.JobType
                                 + '<br/><br/> job created By: ' + job.CreatedBy.email
                                 +'<br/><br/> batch job status: ' + job.Status
                                 + '<br/><br/> total number of batches: ' + job.TotalJobItems
                                 + '<br/><br/> NumberOfErrors: ' + job.NumberOfErrors;
        email.setHtmlBody(emailcontent);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        
    }
    
    public static void sendtotalAnnualRevenueNotification(asyncApexJob job, string jobName,decimal totalAnnualRevenue)
    {
        system.debug('email method');
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        string[] toaddress = new string[]{job.createdby.email,'annapureddy.reddy04@infosys.com'};
        string[] bccaddress = new string[]{job.createdby.email,'annapureddy.reddy04@infosys.com'};
        string[] ccaddress = new string[]{job.createdby.email,'annapureddy.reddy04@infosys.com'};
            email.setToAddresses(toaddress);
            email.setCcAddresses(ccaddress);
            email.setBccAddresses(bccaddress);
         string subject = 'batch job name: ' + jobName + 'job id:  ' + job.Id;
        email.setSubject(subject);
        email.setReplyTo('annapureddy.reddy04@infosys.com');
        
        string htmlBody = 'hello customer:  ' + 
                          '<br/><br/> job details: ' +
                          '<br/> job name: ' + jobName +
                          '<br/> job Id: ' + job.Id +
                           '<br/> job status: ' + job.Status +
                           '<br/> totaljobitems: ' + job.TotalJobItems +
                           '<br/> jobitemsprocessed: ' + job.JobItemsProcessed +
                           '<br/> job type: ' + job.JobType +
                            '<br/> created by: ' + job.createdby.email +
                            '<br/> total Annual Revenue: ' + totalAnnualRevenue;
        
        
        email.setHtmlBody(htmlBody);
        email.setSenderDisplayName('caluculate account annual revenue batch job notification');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});                         
                           
           
          
    }

    public static void sendEmailFailedRecords(List<string> failedrecordIds,List<string> failedMessages)
    {
        system.debug('failedrecordIds@@: ' + failedrecordIds);
        system.debug('failedMessages@@: ' + failedMessages);
        set<string> failedRecordSet = new set<string>(failedMessages);
        system.debug('failedRecordSet@@: ' + failedRecordSet);
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>(); // ()

        Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
        List<string> toList = new List<string>{'reddy843@gmail.com'}; // ('reddy843@gmail.com')
        emailObj.setToAddresses(toList); // setToAddresses(toAddresses)
        emailObj.setCcAddresses(toList);
        emailObj.setBccAddresses(toList);
        emailObj.setSenderDisplayName('failed records rajasekhar');
        emailObj.setSubject('failed records and failed messages');
        string body = 'heare are failed records: <br/><br/> ' 
                          + failedrecordIds
                          + '<br/><br/> failed messages: ' + failedRecordSet;
        emailObj.setHtmlBody(body);
        emailList.add(emailObj);
        system.debug('emailList: ' + emailList); // (Messaging.SingleEmailMessage:[getToAddresses=();getSubject=;getBody=()])

       List<Messaging.SendEmailResult> result = Messaging.sendEmail(emailList);
       system.debug('result: ' + result); // (Messaging.singleEmailResult: [getErrors=();isSusccss=true])

       for(Messaging.SendEmailResult str: result)
       {
        if(str.isSuccess())
        {
            system.debug('eamil is sent successfully');
            system.debug('str.getErrors(): ' + str.getErrors());
        }
        else
        {
            system.debug('failed record: ' + str.getErrors());

        }

       }


    }


    public static void sendEmailWithJobDetails(asyncApexJob apexJobObj)
    {
        system.debug('apexJobObj@@: ' + apexJobObj);
        
   List<Messaging.SingleEmailMessage> emailsList = new List<Messaging.SingleEmailMessage>(); // ()
   Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage(); // Messaiging.SingleEmailMessage[{getCCAddrees=();}]
   system.debug('emailObj: ' + emailObj);
   String[] toList = new String[]{'reddy843@gmail.com'}; // (reddyy843@gmail.com)
    emailObj.setToAddresses(toList);
    emailObj.setCcAddresses(toList);
    emailObj.setBccAddresses(toList);
    emailObj.setReplyTo('reddyy843@gmail.com');
    string emailSubject = 'jobId: ' + apexJobObj.Id + ' job Name: ' + apexJobObj.ApexClass.Name + ' successfully completed';
   emailObj.setSubject(emailSubject);
    emailObj.setSenderDisplayName('Batch Completion notfication');

    String htmlBody = 'Hi user, '
                      + apexJobObj.CreatedBy.Name
                      + '<br/> jobId: ' + apexJobObj.Id
                      + '<br/> jobName: ' + apexJobObj.ApexClass.Name
                      + '<br/> jobStatus: ' + apexJobObj.Status
                      + '<br/> totaljobItems: ' + apexJobObj.TotalJobItems
                      + '<br/> jobItemsProcessd: ' + apexJobObj.JobItemsProcessed
                      + '<br/> NumberOfErrors: ' + apexJobObj.NumberOfErrors
                      + '<br/> CompletedDate: ' + apexJobObj.CompletedDate
                      + '<br/> ExtendedStatus: ' + apexJobObj.ExtendedStatus;

   system.debug('htmlBody: ' + htmlBody);
   emailObj.setHtmlBody(htmlBody);
   system.debug('emailObj@: ' + emailObj);
  emailsList.add(emailObj);
  system.debug('emailList: ' + emailsList); // (Messaging.SingleEmailMessage[getToAddresses=();getCCAddresses=();],Messaging.SingleEmailMessage[getToAddresses=();getCCAddresses=();])

List<Messaging.SendEmailResult> result = Messaging.sendEmail(emailsList);
system.debug('result: ' + result); // (Messaging.SendEmailResult: [getErrors=();isSuccess=true],Messaging.SendEmailResult: [getErrors=(Database.Error[getFields=();getStatusCode=();getMessage=()]);isSuccess=false])

for(Messaging.SendEmailResult str: result)
{
  if(str.isSuccess())
  {
    system.debug('email sent successfully');

  }
  else
  {
    for(Database.error errorObj: str.getErrors())
    {
      system.debug('errorObj: ' + errorObj);
      system.debug('statuscode: ' + errorObj.getStatusCode());
      System.debug('message: ' + errorObj.getMessage());

    }
  }
  
}
    }



}