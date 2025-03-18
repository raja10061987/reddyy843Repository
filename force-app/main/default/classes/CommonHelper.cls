public class CommonHelper {
    
    public static void  getAccountsCount()
    {
        /*
        integer accountCount = [select count() from account];
        system.debug('records count: ' + accountCount);
          */
        
        string countQuery = 'select count() from account';
        integer myaccountCount = database.countQuery(countQuery);
        system.debug('myaccountcount: ' + myaccountCount);
    }
    
    public static void getcasesBasedOnPriority(string casePriority)
    {
        if(casePriority != null && casePriority != ''){
       string query = 'select status,priority,origin,type,reason from case where priority=:casePriority';
       List<case> caseList = Database.query(query);
            system.debug('caseList size: ' + caseList.size());
            for(Case caseObj:caseList){
                system.debug('case record: ' + caseObj);
            }
        }
        
        
        
    }
    
    
    public static void getLeadIndustryRecords(string industryName)
    {
        List<Lead> leadList = [select id,name,phone,status,company,LeadSource,industry 
                               from lead 
                               where industry=:industryName];
        system.debug('leadlist size: ' + leadlist.size());
        if(!leadList.isEmpty())
        {
            for(Lead leadObj:leadList){
                system.debug('Lead name: ' + leadObj.name);
                system.debug('industry: ' + leadObj.Industry);
                system.debug('--------------------------');
            }
            
        }
    }
    
    public static void getOnlyRecycleBinRecords()
    {
        List<Account> actList = [select id,name,rating,phone,active__c,isDeleted from account where isdeleted=false All Rows];
        
        system.debug('actLis size: ' + actList.size());
        system.debug('actList: ' + actList);
        if(!actList.isEmpty()){
            for(Account actObj:actList){
                system.debug('Id: ' + actObj.Id);
                system.debug('Name: ' + actObj.Name);
                system.debug('---------------------------');
            }
        }
    }
    
    
    public static void getBankingAccounts(string rating,string industry)
    {
        List<Account> actList = [select id,rating,phone,fax,type,industry,active__c from account 
                                 where rating=:rating and industry=:industry];
        system.debug('actList size: ' + actList.size());
        system.debug('actList: ' + actList);
        if(!actList.isEmpty())
        {
            for(Account actObj:actList){
            system.debug('account record: ' + actObj);
        }
        }
        
    }
    
    public static void exportAllAccounts()
    {
        
        
            for(Account actObj:[select id,name,fax,phone,isdeleted from account all rows]){
                system.debug('account record: ' + actObj);
            }
        
    }
    
    public static void getContactsRecordByOffset(integer limitValue,integer offsetValue){
        List<Contact> listContcts = [select id,firstname,lastname,phone,homephone from contact where
                                     firstname != null limit:limitValue offset:offsetValue];
        system.debug('listContacts: ' + listContcts.size());
        if(!listContcts.isEmpty()){
            for(Contact conObj:listContcts){
                system.debug('Contact Record: ' + conObj);
            }
        }
    }
    
 
     public static void createBulkAccountRecords()
     {
         List<Account> actList = new List<Account>();
         /* create bulk Records */
         for(integer counter = 10;counter <=200;counter++){
             Account actObj = new Account();
             actObj.Name = 'sumathi-' + counter;
             actObj.Phone = '8309351867';
             actObj.Rating = 'Hot';
             actList.add(actObj);
            
         }
         if(!actList.isEmpty()){
             insert actList;
             system.debug('number of DML statements used: ' + system.Limits.getDmlStatements());
             system.debug('get the number of the rows processd: ' + system.Limits.getDmlRows());
             system.debug('actList: ' + actList);
         }
     }
    
    public static void createBulkHRRecords()
    {
        List<Hiring_manager__c>  listHrs = new List<Hiring_manager__c>();
        for(integer counter = 1;counter <=200; counter++)
        {
        Hiring_manager__C hrObj = new Hiring_Manager__C();
        hrObj.Name = 'suman kumar-' +counter ;
        hrObj.Location__c = 'bangalore';
        hrObj.Email_Id__c = 'reddyy467@gmail.com';
        hrObj.Designation__c = 'Hr Manager';
        hrObj.Contact_Number__c = '8309351867';
        listHrs.add(hrObj);
        }
        if(!listHrs.isEmpty()){
            insert listhrs;
            system.debug('number DML statements processed: ' + system.Limits.getDmlStatements() ); // 1 out of 150
            system.debug('number of the records processed: ' + system.Limits.getDmlRows()); // 200 out of 10000
            system.debug('lisstHrs: ' + listHrs);
           
        }
        
    }
    
    public static void createbulkaccountrelatedcontactCaseRecords()
    {
        Account actObj = new Account();
        actObj.Name = 'rajasekhara';
        actObj.Rating = 'Hot';
        actObj.Phone = '1234235';
        actObj.AnnualRevenue = 240000;
        actObj.Active__c = 'true';
        insert actObj;
        system.debug('accuont Object: ' + actObj);
        /* if the account id is there insert 10 contacts and 5 case records */
        
        if(actObj.Id != null){
            system.debug('account Id: ' + actObj.Id);
            
            List<Contact> listContacts = new list<Contact>();
            for(integer counter=1;counter <10;counter++){
                Contact conObj = new Contact();
                conObj.LastName = 'shankar - ' + counter;
                conObj.FirstName = 'annapureddy';
                conObj.Phone = '8309351867';
                conObj.Email = 'reddyy843@gmail.com';
                conObj.AccountId = actObj.Id;
                listContacts.add(conObj);
            }
            
            if(!listContacts.isEmpty()){
                insert listContacts;
                system.debug('listContacts: ' + listContacts);
            }
            
            /* prepare 5 case records */
            
            List<Case> caseList = new List<Case>();
            for(integer counter=1;counter <=5;counter++){
                Case caseObj = new Case();
                caseObj.Status = 'new';
                caseObj.Origin = 'Web';
                caseObj.Type = 'Other';
                caseObj.Reason = 'Other';
                caseObj.Priority = 'High';
                caseObj.AccountId = actObj.id;
                caseList.add(caseObj);
            }
            if(!caseList.isEmpty()){
                insert caseList;
                system.debug('caseList: ' + caseList);
                system.debug('number of DML commands processed: ' + system.Limits.getDmlStatements());
                system.debug('number of the records processed: ' + system.Limits.getDmlRows());
            }
        }
    }
    
    public static void createbulkHrrelatedPositionCandidateRecords()
    {
        Hiring_manager__c hrObj = new Hiring_manager__c();
        hrobj.Name = 'chathrapathi';
        hrObj.Location__c = 'Bangalore';
        hrObj.Email_Id__c = 'reddyy843@gmail.com';
        hrObj.Designation__c = 'Hr Executive';
        hrObj.Contact_Number__c = '8309351867';
        system.debug('hrObj: ' + hrObj);
        insert hrObj;
        if(hrObj.Id != null)
        {
            system.debug('hrObject: ' + hrObj);
            createbulkHrrelatedPositionCandidateRecords(hrObj);
            
        }
       
    }
    
     public static void createbulkHrrelatedPositionCandidateRecords(Hiring_manager__c hrObj)
     {
         List<position__c> positionList = new List<position__c>();
         for(integer counter = 1;counter <=10;counter++)
         {
         position__c pObj = new position__c();
         pObj.Name = 'senior salesforce developer';
         pObj.Location__c = 'Bangalore';
         pObj.Number_Of_Vacancies__c = 3;
         pobj.Position_Status__c = 'New Position';
         pObj.Minimum_Pay__c = 230000;
         pObj.Maximum_Budget__c = 3500000;
         pObj.Open_date__c = system.today();
         pObj.MileStone_Date__c = system.today() + 10;
         pObj.HR_Email_ID__c = hrObj.Email_Id__c;
             /* related record */
         pObj.Hiring_Manager_Id__c = hrObj.Id;
         positionList.add(pObj);
         }
        if(!positionList.isEmpty())
        {
            insert positionList;
        }
         /* create 2 candidate records for each position record */
      
         for(Position__c pObj:positionList){
             List<candidate__c> canList = new List<candidate__c>();
             for(integer counter= 1;counter <=2;counter++){
                candidate__c canObj = new candidate__c();
                 canObj.Name = 'raja - ' +counter;
                 canObj.Email_id__c = 'reddyy467@gmail.com';
                 canObj.Notice_period__c = '1 Month';
                 canobj.Location__c = 'Bangalore';
                 canObj.Experience__c = 10;
                 canObj.Expected_CTC__c = 240000;
                 canObj.Phone__c = '8309351867';
                 canObj.Position__c = pObj.Id;
                 canList.add(canObj);
             }
             if(!canList.isEmpty()){
                 insert canList;
             }
             system.debug('number of insert statements processed: ' + system.Limits.getDmlStatements());
             system.debug('number of the records processed: ' + system.Limits.getDmlRows());
         }
        
     }
    
    public static void getSOQLQuries()
    {
        List<Account> actList = [SELECT Id,name,type,billingCity,BillingState FROM Account limit 2];
         system.debug('accountObj: ' + actList.size());
        if(!actList.isempty()){
         for(Account actObj:actList){
        system.debug('Id: ' + actObj.Id);
        system.debug('Name: ' + actObj.Name);
        system.debug('type: ' + actObj.Type); 
        system.debug('billingCity: ' + actObj.BillingCity);
        system.debug('billingState: ' + actObj.BillingState);
        system.debug('---------------------------------------');
        }

            
        }
             
    }
   
    
    public static void getAllCaseRecords()
    {
        for(Case caseObj:[select status,origin,subject,description,priority,type,reason,isdeleted from case limit 2])
        {
            system.debug('case record: ' + caseObj);
            system.debug('staus: ' + caseObj.Status);
            system.debug('origin: ' + caseObj.Origin);
            system.debug('description: '+ caseObj.Description);
            system.debug('priority: ' + caseobj.Priority);
            system.debug('type: ' + caseObj.Type);
            system.debug('reason: ' + caseObj.Reason);
            system.debug('isdeleted: ' + caseObj.IsDeleted);
            system.debug('--------------------------------------------------------------');
        }
    }
    
    public static void getAllHRRecords()
    {
       /* List<Hiring_Manager__c> hrList = [select name,location__c,email_id__c,designation__c,contact_Number__c,id from hiring_manager__C limit 2];
        system.debug('hrList: ' + hrList); */
        
        /* Id=hiring manager Id ,object: hiring manaber Object*/
Map<Id,Hiring_manager__c> mappingHrs = new Map<Id,Hiring_manager__C>([select name,location__c,email_id__c,designation__c,contact_Number__c,id from hiring_manager__C limit 2]);
       
        system.debug('mappingHrs Ids: ' + mappingHrs.values());
        for(hiring_manager__C hrObj:mappingHrs.values()){
            system.debug('name: ' + hrObj.Name);
            system.debug('location: ' + hrObj.Location__c);
            system.debug('email Id: ' + hrObj.Email_Id__c);
            system.debug('designation: ' + hrObj.Designation__c);
            system.debug('----------------------------------------------------------');
        }
        
        
    }

       public static void getAllHRRecords1()
        {
           
            Map<Id,Hiring_manager__C> mapHrList = new Map<Id,Hiring_manager__C>([select id,name,Location__c,Email_id__c,Designation__c,Contact_number__c from hiring_manager__C limit 2 ]);
            system.debug('mapHrList: ' + mapHrList);
            system.debug('mapHrList: ' + mapHrList.keySet());
            system.debug('values: ' + mapHrList.values());
            for(Hiring_manager__C hrObj:mapHrList.values()){
                system.debug('HR Name: ' + hrObj.Name);
                system.debug('Location: ' + hrObj.Location__c);
                system.debug('Email Id: ' + hrObj.Email_Id__c);
                system.debug('------------------------------------');
            }
            
            
        }    
}