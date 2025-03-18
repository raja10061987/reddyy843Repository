public with sharing class ApexFlowSeriesCase {
    

    @InvocableMethod(Label = 'Send email to Contact' description='send email to contact' category='case')
    public static void sendEmailtoContact(List<Requests> requestList)
    {
        System.debug('requestList: ' + requestList);  // requestList: (Requests:[caseId=5005g00000c4DzZAAU, contactId=0035g00000o5K90AAE, cseNuber=00005959])
        system.debug('requestList.get(0): ' + requestList.get(0)); // Requests:[caseId=5005g00000c4DzZAAU, contactId=0035g00000o5K90AAE, cseNuber=00005959]
        String contactId = requestList.get(0).contactId; // (Requests: [CaseId=500hdd,ContactId=00334,cseNumber=001333])
        String caseNumber = requestList.get(0).cseNuber;
        system.debug('contactId: ' + contactId);
        system.debug('caseNumber: ' + caseNumber);

        
        List<Messaging.singleEmailMessage> messageList = new List<Messaging.singleEmailMessage>();
        Messaging.singleEmailMessage  message = new Messaging.singleEmailMessage();
        message.toAddresses = new String[] {contactId};
        message.subject = 'your case has been received - ' + caseNumber;
        message.plainTextBody = 'your case has been received. stared working on this';
        message.setSaveAsActivity(true);
        messageList.add(message); // (Messaging.singleEmailMessage: [toAddress=('hdgs@',dgdg@)])
        System.debug('messageList: ' + messageList);
       Messaging.sendEmailResult[] results =  Messaging.sendEmail(messageList);
       if(results[0].success)
       {
        System.debug('the email was went successfully');

       }
       else {
        system.debug('the email faild to send: ' + results[0].errors[0].message);
       }

    }

    public class Requests
    {
       

        @InvocableVariable(Label='record Id' description='the Id of the case record' required=true)
        public Id caseId;

        @InvocableVariable(Label='contact Record Id' description='the Id of the contact Record' required=true)
        public Id contactId;

        @InvocableVariable(Label='case Number' description='the case number' required=true)
        public String cseNuber;

    }
}