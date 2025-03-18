public class DMLHelper {

    public static void updateAccountAnnualRevenue(string actName)
    {
        if(actName != '' && actName != null){
            List<Account> actsToUpdate = new List<Account>();
            system.debug('actname: ' + actName);
            List<Account> actList = [select id,name,industry,annualrevenue from account where name=:actName];
            system.debug('actLis: ' + actList);
            if(!actList.isEmpty() && actList.size() > 0){
                for(Account actObj:actList){
                    if(actObj.Industry == 'Banking'){
                        system.debug('act industry: ' + actObj.Industry );
                        actObj.AnnualRevenue = 7900000;
                    }
                    else if(actObj.Industry == 'Finance'){
                        system.debug('act industry: ' + actObj.Industry );
                        actObj.AnnualRevenue = 6400000;
                    }
                    else if(actObj.Industry == 'Insurance'){
                        system.debug('act industry: ' + actObj.Industry );
                        actObj.AnnualRevenue = 5500000;
                    }
                    else if(actObj.Industry == 'Manufacturing'){
                        system.debug('act industry: ' + actObj.Industry );
                        actObj.AnnualRevenue = 3900000;
                    }
                    else if(actObj.Industry == 'Education'){
                        system.debug('act industry: ' + actObj.Industry );
                        actObj.AnnualRevenue = 8100000;
                    }
                    else if(actObj.Industry == 'Consulting'){
                        system.debug('act industry: ' + actObj.Industry );
                        actObj.AnnualRevenue = 4500000;
                    }
                    actsToUpdate.add(actObj);
                }
                
                if(!actsToUpdate.isEmpty() && actsToUpdate.size() > 0){
                    update actsToUpdate;
                    system.debug('actsToUpdate: ' + actsToUpdate);
                }
                
            }
            
        }
        
    }
    
    public static void updateContactsMailingAddress(string actName)
    {
        if(actName != '' && actName != null){
            system.debug('actName: ' + actName);
            List<Contact> conListUpdate = new List<Contact>();
             List<Account> actList = [select id,name,phone,fax,billingstreet,billingcity,billingstate,billingpostalcode,billingcountry,
                                     (select id,name,phone,fax,mailingstreet,mailingcity,mailingstate,mailingpostalcode,mailingcountry from contacts) 
                                                       from account 
                                                        where name=:actName];
            system.debug('actList: ' + actList);
            if(!actList.isEmpty() && actList.size() > 0){
                for(Account actObj: actList){
                   // system.debug('account Record: ' + actObj.contacts);
                    for(Contact conObj:actObj.contacts){
                        conObj.Phone = actObj.Phone;
                        conObj.Fax = actObj.Fax;
                        conObj.MailingStreet = actObj.BillingStreet;
                        conObj.MailingCity = actObj.BillingCity;
                        conObj.MailingState = actObj.BillingState;
                        conObj.MailingPostalCode = actobj.BillingPostalCode;
                        conObj.MailingCountry = actObj.BillingCountry;
                         conListUpdate.add(conObj);
                    }
                    system.debug('=============================');
                }
                if(!conListUpdate.isEmpty() && conListUpdate.size() > 0){
                    update conListUpdate;
                }
            }
        }
        
    }
    
    public static void updateAccountRecords(string industryName)
    {
        if(industryName != null && industryName != '')
        {
            system.debug('industryName: ' + industryName);
            List<Account> actstoUpdate = new List<Account>();
            List<Account> actList = [select id,name,phone,industry,rating,annualrevenue from account where industry=:industryName];
            if(!actList.isEmpty() && actList.size() > 0){
                for(Account actObj:actList){
                    actObj.Rating = 'warm';
                    actObj.AnnualRevenue = 7000000;
                    actstoUpdate.add(actObj);
                }
                if(!actstoUpdate.isEmpty() && actstoUpdate.size() > 0){
                   update actstoUpdate;
                }
            }
            
        }
        
    }
    
    public static void deleteHrandRelatedPositionRecords(string hrName)
    {
        if(hrName != '' && hrName != null)
        {
        List<Hiring_manager__C> hrListToDelete = new List<Hiring_manager__C>();
        List<Position__c> positionsToDelete = new  List<Position__c>();
        List<Hiring_manager__C> hrList = [select id,name,location__c,email_id__c,(select id,name from Positions__r) from Hiring_Manager__C where name like: '%'+hrName];
        for(Hiring_manager__C hrRecord:hrList){
            hrListToDelete.add(hrRecord);
            for(Position__c pObj:hrRecord.positions__r){
                positionsToDelete.add(pObj);
            }
        }
        system.debug('hrListToDelete: '+ hrListToDelete.size());
        system.debug('positionsToDelete: ' + positionsToDelete.size());
            if(!hrListToDelete.isEmpty() && hrListToDelete.size() > 0){
                delete hrListToDelete;
            }
            if(!positionsToDelete.isEmpty() && positionsToDelete.size() > 0){
                delete positionsToDelete;
            }
        }
       
            
        }
        
    public static void deleteAccountRecordsByName(string actName)
    {
        if(actName!= '' && actName!=null)
        {
        List<Account> actList = [select id,name,phone,industry,active__c from account where name like:actName +'%'];
        system.debug('actsize: ' + actList.size());
        system.debug('actList: ' + actList);
            if(!actList.isEmpty()){
                delete actList;
            }
        }
    }
    
    public static void createAccountrelatedTasksandEvents()
    {
        // create account record
        Account actObj = new Account();
        actObj.AccountNumber = '12334';
        actObj.Name = 'new account1234';
        actObj.Phone = '123456';
        actObj.Active__c = 'yes';
        actObj.AnnualRevenue = 230000;
        actObj.BillingCity = 'Hyderabad';
        actObj.Rating = 'Hot';
        insert actObj;
        system.debug('actObj id' + actObj.Id);
        
        if(actObj.Id != null){
        // create task record
         task taskObj = new task();
        taskObj.Status = 'Not started';
        taskObj.Priority = 'Normal';
        taskObj.Status = 'New task created through apex programming';
        // assign the task to the account
        taskObj.WhatId = actObj.Id;
        insert taskObj;
          system.debug('taskId: ' + taskObj.Id);
        
        // create Event record
        
        Event eventRecord = new Event();
        eventRecord.Subject = 'Event is created through apex programming';
        eventRecord.StartDateTime = system.today();
        eventRecord.EndDateTime = system.today() + 10;
        eventRecord.WhatId = actObj.id;
        
        insert eventRecord;
            system.debug('eventRecordId: ' + eventRecord.Id);
        }
    }
    
    public static void assiginContactstoAccount(string accountRecordName)
    {
        List<Contact> contacttoUpdate = new List<Contact>();
        List<Contact> conList = [select id,Name,mobilephone,email,Department,accountId from Contact where accountid = null];
        
        // system.debug('before accountId update: conList: ' + conList);  // 0015g00000EDfUzAAL
        // system.debug('actId: ' + actId);
        if(!conList.isEmpty() && conList.size() > 0){
            ID actId = [select id,name,phone,industry,active__c,ownerId from account where name=:accountRecordName limit 1].Id;
            if(actId != null){
                for(Contact conRecord:conList){
                    conRecord.AccountId = actId;
                    contacttoUpdate.add(conRecord);
                }
               // system.debug('after accountId update: ContactList ' + contacttoUpdate);
            }
            
        }
        // insert new contact Record
          Contact conObj = new Contact();
          conObj.FirstName = 'raja';
          conObj.LastName = 'reddy';
          conObj.HomePhone = '1124234';
          conObj.Email = 'reddyy843@gmail.com';
          conObj.Budget__c = 230000;
         
        // assighn the conObj to the List
         contacttoUpdate.add(conObj);
         system.debug('contactList size: ' + contacttoUpdate.size());
         system.debug('contacttoUpdate: ' + contacttoUpdate);
        if(!contacttoUpdate.isEmpty()){
            upsert contacttoUpdate;
        }
        
        
    }
    
    public static void transferRecords(){
        
        List<Account> actList = [select id,name,phone,industry,active__c,ownerId from account where industry = 'Banking'];
        if(!actList.isempty()){
            User userrecord = [select id,username,Lastname,isActive,phone,name from user where name='raja1 reddy1' and isActive = true];
            for(Account actRecord:actList){
                if(userrecord.Id !=null){
                    actRecord.ownerId = userrecord.Id; 
                }
                
                
            }
            update actList;
        }
    }
    
    public static void deActivateUser(string username)
    {
        if(username != '' && username!= null){
            system.debug('username: ' + username);
        User uerRecord = [select id,username,Lastname,isActive,phone from user where username=: username];
        if(uerRecord.id != null){
            uerRecord.IsActive = false;
           update uerRecord;
        }
        }
        
    }
    public static void updateeCasePriorityHigh()
    {
        List<case> caseList = [select id,status,priority,origin from case where status= 'new' limit 10];
        system.debug('caseList size: ' + caseList.size());
        system.debug('caseList: before updating Priority: ' + caseList);
        if(!caseList.isEmpty()){
            for(case caseRecord: caseList){
                caseRecord.Priority = 'High';
            }
            update caseList;
        }
        
    }
    public static void restoreUndeleteRecords()
    {
        List<Hiring_manager__c> hrList = [select id,name,location__c,Email_Id__c,isDeleted from Hiring_manager__C 
                                          where isDeleted=true ALL ROWS];
        system.debug('hrList size: ' + hrList.size());
        undelete hrList;
        if(!hrList.isEmpty()){
            for(Hiring_manager__C hrRecord:hrList){
                if(hrRecord.IsDeleted == true){
                    system.debug('not delted records: ' + hrRecord);
                }
            }
        }
        
    }
    
    public static void undeleteaccountRecords()
    {
        List<Account> actList = [select id,name,isDeleted from account where isDeleted=false all rows];
        system.debug('actList size: ' + actList.size());
        if(!actList.isEmpty()){
            delete actList;
           // undelete actList;
            //for(Account actRecord:actList){
              //  if(actRecord.isDeleted == true){
                //    system.debug('deleted record ' + actRecord);
                // }
            // }
        }
    }

    public static void createBulkHrRecords(){
        List<Hiring_manager__c> hrList = new List<Hiring_manager__c>();
        for(integer counter=1;counter<=200;counter++){
            Hiring_manager__c hrObj = new Hiring_manager__c();
            hrObj.Name = 'prabhas- ' + counter;
            hrObj.Email_Id__c = 'reddyy843@gmail.com';
            hrObj.Location__c = 'Hyderabad';
            hrObj.Designation__c = 'Hr Executive';
            hrObj.Contact_Number__c = '8309351867';
            hrList.add(hrObj);
        }
        system.debug('hrList size: ' + hrList.size());
        if(!hrList.isEmpty()){
            insert hrList;
        }
        
    }
    
    public static void deleteBulkHRRecords(string hrname){
        system.debug('hrName: ' + hrname);
       
      //  List<Hiring_manager__C> hrList = [select id,name,Location__c,Email_id__c,Designation__c,Contact_Number__c from Hiring_Manager__c 
                                         // where name like: hrname+'%'];
      //  system.debug('hrList size: ' + hrList.size());
           //if(!hrList.isEmpty()){
              //  delete hrList;
               // system.debug('deleted all records:');
           // }
           
            if(hrname!='' && hrname!= null){ 
                delete [select id,name,Location__c,Email_id__c,Designation__c,Contact_Number__c from Hiring_Manager__c 
                                         where name like: hrname+'%'];
           }
        
        
    }
}