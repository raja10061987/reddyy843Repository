public with sharing class AccountUpdateBatchJob implements Database.Batchable<sObject>
{
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        String query = 'select Id,Name,AccountNumber from Account';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc,List<Account> records)
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
        try
        {
            Database.saveResult[] result = Database.Insert(accountList,true);
        }
        catch(Exception ex)
        {
            List<Account_Creation_Event__e> eventList = new List<Account_Creation_Event__e>();
            Account_Creation_Event__e	 eventObj = new Account_Creation_Event__e	();
               eventObj.Error_Description__c	= ex.getMessage();
               eventList.add(eventObj);
            
        }
        
        

        // try {
        //     Database.saveResult[] result = Database.Insert(accountList,true);
        //       system.debug('result: ' + result);
            
        // } catch (Exception ex) 
        // {
        //     List<Account_Creation_Event__e> eventList = new List<Account_Creation_Event__e>();
        //        Account_Creation_Event__e eventObj = new Account_Creation_Event__e();
        //        eventObj.Error_Description__c	= ex.getMessage();
        //        eventList.add(eventObj);
        //        Database.saveResult[] result1 = EventBus.publish(eventList); 

        //        for(Database.saveResult str:result1)
        //        {
        //             if(str.isSuccess())
        //             {
        //                 system.debug('succssfully published platform event: ' + str.getId());

        //             }
        //             else
        //             {
        //                 for(Database.error error: str.getErrors())
        //                 {
        //                     system.debug('getMessage: ' + error.getMessage());
        //                     system.debug('fields: ' + error.getFields());
        //                     system.debug('getStatus Code: ' + error.getStatusCode());
                            
        //                 }
        //             }

        //        }
   
        // }
        

    }

    public void finish(Database.BatchableContext bc)
    {
        System.debug('send email notification, batch completed notification');
       
        // Map<string,Account> actsMap = new Map<string,Account> ([select Id,Name from Account limit 10]);
        // set<String> atsSet = actsMap.keyset(); // {00122ba,001jsabca}
        // List<String> actsIdsList = new List<String>(atsSet);

        // MixedDMLClass.mixedDMLMethod(actsIdsList);


    }
}