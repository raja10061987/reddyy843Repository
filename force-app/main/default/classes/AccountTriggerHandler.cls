public with sharing class AccountTriggerHandler 
{
    public static void sendEmailOnunDelete(List<Account> newActList)
    {
         // Trigger.New /Trigger.NewMap available
        // Trigger.Old not available
        system.debug('newActList@@: ' + newActList);
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

        for(Account newAccount:newActList)
        {
            Messaging.SingleEmailMessage obj = new Messaging.SingleEmailMessage();
            List<String> toList = new List<String>();
            toList.add(userInfo.getUserEmail());
            obj.setToAddresses(toList);
            obj.setSubject('hi account is restored/undelete successfully:  ' + newAccount.Name + newAccount.Id);
            obj.setPlainTextBody('hi there is no body: ' + newAccount.Rating);
            emailList.add(obj);

        }
        system.debug('emailList: ' + emailList); // (Messaging.SingleEmailMessage: [])
        Messaging.sendEmail(emailList);


    }

    public static void sendEmailOnDelete(List<Account> oldRecords)
    {
        List<Messaging.SingleEmailMessage> mailsList = new List<Messaging.SingleEmailMessage>(); //()
        system.debug('oldRecords: ' + oldRecords);
        for(Account actObj:oldRecords)
        {
            Messaging.SingleEmailMessage mailObj = new Messaging.SingleEmailMessage();
            List<String> toSendList = new List<String>(); // (reddyy843@gmail.com)
            toSendList.add(userInfo.getUserEmail()); 
            mailObj.setToAddresses(toSendList);
            mailObj.setSubject('account deleted successfully: ' + actObj.Name);
            mailObj.setPlainTextBody('there is no bod, please refer subject');
            mailsList.add(mailObj); 

        }
        system.debug('mailList@@123: ' + mailsList); // (Messaging.SingleEmailMessage:[setToAddresses=(abcd@gmail.com,ss@gmail.com),setSubject=hello,setPlainTextBody=hi])
        Messaging.sendEmail(mailsList);


    }
   
}