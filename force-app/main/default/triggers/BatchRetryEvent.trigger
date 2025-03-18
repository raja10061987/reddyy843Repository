trigger BatchRetryEvent on Account_Creation_Event__e (after insert) 
{
    system.debug('Account_Creation_Event__e:');
    List<Btach_Retry_Event__c> errorList = new List<Btach_Retry_Event__c>();
    if(trigger.isAfter && trigger.isInsert)
    {
        system.debug('trigger.New: ' + trigger.New); // (Account_Creation_Event__e:{Error_Description__c=,Phone__C=''})

        for(Account_Creation_Event__e eventObj: trigger.new)
        {
          if(String.isNotBlank(eventObj.Class_Name__c))
          {
            Type classType = Type.forName(eventObj.Class_Name__c);
            system.debug('classType: ' + classType);
            Object classInstance = classType.newInstance();
            system.debug('classInstance: ' + classInstance);

            if(classInstance instanceOf Database.Batchable<sObject>)
            {
              Id batchJobId = Database.executeBatch((Database.Batchable<sObject>)classInstance, eventObj.Batch_Size__c == null ? 200: eventObj.Batch_Size__c.intValue());
              System.debug('batchJobId: ' + batchJobId);

            }
            else if(classInstance instanceOf System.queueable)
            {
              Id queableJobId = System.enqueueJob((System.queueable)classInstance);
              System.debug('queableJobId: ' + queableJobId);

            }

          }

        }
       

//         ExportChargesToERPQueable job = new ExportChargesToERPQueable();
 
//         Id jobId =System.enqueueJob(job);
//         System.debug(' ExportChargesToERPQueable jobId: ' + jobId);

        
//    RecalCommissin_Queable job1 = new RecalCommissin_Queable();
 
//           Id recaljobId =System.enqueueJob(job1);
//          System.debug('recal jobId: ' + recaljobId);

                // for(Account_Creation_Event__e eventObj: trigger.new)
                // {
                //     if(String.isNotBlank(eventObj.Class_Name__c))
                //     {
                //        Type classType = Type.forName(eventObj.Class_Name__c);
                //        System.debug('classType: ' + classType);
                //       Object classInstance = classType.newInstance();
                //       System.debug('classInstance: ' + classInstance);
                //       if(classInstance instanceOf Database.Batchable<sObject>)
                //       {
                //         System.debug('Batch job executed from platform event trigger');
                //         Database.executeBatch((Database.batchable<sObject>) classInstance,eventObj.Batch_Size__c == null ? 200: eventObj.Batch_Size__c.intValue());

                //       }
                //       else if (classInstance instanceOf System.queueable)
                //       {
                //         System.debug('queable seduled from platform event trigger');
                //         system.enqueueJob((System.Queueable)classInstance);
                        
                //       }
                      




                //     }

                // }


        // for(Account_Creation_Event__e eventObj: trigger.new)
        // {
        //     Btach_Retry_Event__c obj = new Btach_Retry_Event__c();
        //     obj.Error_Message__c = eventObj.Error_Description__c;
        //     obj.RecordIds__c = 'insert/update1';
        //     errorList.add(obj);
            
        // }
        //   insert  errorList;
        // system.debug('after insert errorList: ' + errorList);

        // Profile proObj = [SELECT Id,Name FROM Profile  WHERE Name='Contract Manager'];
        // UserRole role = [select Id,Name from userRole  where Name='CFO_ManagerUser'];
        // User userObj = new User();
        // userObj.Alias = 'alias';
        // userObj.Email = 'abcdefg@gmail.com';
        // userObj.Emailencodingkey = 'UTF-8';
        // userObj.LastName= 'Hours';
        // userObj.Languagelocalekey = 'en_US';
        // userObj.localesidkey = 'en_US';
        // userObj.Timezonesidkey = 'America/Los_Angeles';
        // userObj.Username = 'apexHourshello12@gmail.com';
        // userObj.ProfileId = '00e5g000001AnbMAAS';
        // userObj.Userroleid = role.Id;
        // insert as user userObj;
        // system.debug('userObj: ' + userObj);


    }

  }