public with sharing class DummyClass {
    

    public static void dummyMethod()
    {
        
            List<Account> accountList = new List<Account>();
             Account actObj = new Account();
             actObj.Name = 'rajasekhar1 update2';
             actObj.Phone = '2344789';
             actObj.Rating = 'Hot';

             Account actObj1 = new Account();
             actObj1.Name = '';
             actObj1.Phone = '2344789';
             actObj1.Rating = 'Hot';

             accountList.add(actObj);
             accountList.add(actObj1);
             List<Database.saveResult> result;

             try
            {
               result = Database.insert(accountList,false);
               system.debug('result: ' + result); // (Database.SaveResult:{getErrors=();getId=001agah;isSuccuss=true},Database.SaveResult:{getErrors=(getFiflds=(Name);getStausCode=;);getId=001agah;isSuccuss=true})
            }
            catch(Exception ex)
            {
                List<Account_Creation_Event__e> eventList = new List<Account_Creation_Event__e>();
                // insert failed record in platform event
               Account_Creation_Event__e	 eventObj = new Account_Creation_Event__e	();
               eventObj.Error_Description__c	= ex.getMessage();
               eventList.add(eventObj);
               Database.saveResult[] result1 = EventBus.publish(eventList); // (Account_Creation_Event__e: {Error_Description__c= error})
               system.debug('result1: ' + result1); // (Database.saveResult:{getErros=();getId=001agah;isSuccuss=true})
               for(Database.saveResult str: result1)
                 {
                    if(str.isSuccess())
                    {
                        system.debug('successfully published platform event');

                     }
                     else
                     {
                        for(Database.Error error: str.getErrors())
                           {
                           system.debug('error Code:' + error.getStatusCode());
                            system.debug('error message: ' + error.getMessage());

                           }
                     }
                 }
            }
}
}