public class DataBaseUtility {
    
    public static void getcandidateandrelatedParentDetails(string candidatename)
    {
        if(candidatename!= '' && candidatename != null)
        {
            List<candidate__c> canList = [select id,name,Location__c,notice_period__c,
                                          position__r.name,
                                          position__r.hiring_manager_id__r.name,
                                          position__r.hiring_manager_id__r.owner.name,
                                          position__r.hiring_manager_id__r.owner.profile.name 
                                          from candidate__c where candidate__C.name =:candidatename];
            if(!canList.isEmpty() && canList.size() > 0)
            {
                system.debug('canList size: ' + canList.size());
                for(Candidate__c canRecord: canList){
                    system.debug('canRecord:' + canRecord);
                    system.debug('candidate:position: name:  ' + canRecord.position__r.name);
                    system.debug('candidate:position:hiringmanager:name:  ' + canRecord.position__r.hiring_manager_id__r.name);
                    system.debug('candidate-->position-->hiringmanager-->owner: ' + canrecord.position__r.hiring_manager_id__r.owner.name);
                    system.debug('candidate:position:hiringmanager:owner:profile:name: ' + canRecord.position__r.hiring_manager_id__r.owner.profile.name);
                }
                
            }
            
        }
        
    }
    
    public static void getcandidateAndParentdetails(string candidateName)
    {
        if(candidateName!= null && candidateName!=''){
            system.debug('candidate: ' + candidateName);
            List<candidate__c> canList = [select id,name,location__c,passport_required__C,experience__c,
                                  candidate__c.position__r.name,
                                  position__r.Hiring_manager_id__r.name,
                                  position__r.hiring_manager_id__r.owner.name,
                                  position__r.hiring_manager_id__r.owner.profile.name 
                                  from candidate__c where name =:candidateName];
            if(!canList.isEmpty() && canList.size() > 0){
                for(Candidate__c canrecord: canList){
                    system.debug('candidate Record: ' + canrecord);
                    system.debug('candidate==> position:name: ' + canrecord.position__r.name);
                    system.debug('candidate==>position==>HiringManager.name: ' + canrecord.position__r.hiring_manager_id__r.name);
                    system.debug('candidate==>position==>hiringmanager==>owner:name: ' + canrecord.position__r.hiring_manager_id__r.owner.name);
                    system.debug('candidate==>position==>hiringmanager==>owner==> profile: ' + canrecord.position__r.hiring_manager_id__r.owner.profile.name);
                    
                }
            }
            
        }
        
    }
    
    public static void getHiringmanagerandPositionRecords(string hrName)
    {
        if(hrName!='' && hrName!= null)
        {
            system.debug('hrName: ' + hrname);
            List<Hiring_manager__C> hrList = [select id,name,Location__c,Email_id__c,Designation__c,Contact_number__c,
                                              (select id,name,Location__c,position_status__C from positions__r) 
                                              from Hiring_manager__c where name='suman kumar-10'];
            if(!hrList.isEmpty() && hrList.size() > 0)
            {
                
                for(Hiring_manager__c hrRecord:hrList){
                    system.debug('hrRecord: ' + hrRecord);
                    system.debug('position record size: ' + hrrecord.positions__r.size());
                    for(position__c pObj:hrRecord.positions__r){
                        system.debug('position record: ' + pObj);
                    }
                }
                
            }
            
        }
        
    }
    
    public static void getCaseandRelatedParentDetails(string caseNumber)
    {
        if(caseNumber != '' && caseNumber != null){
            system.debug('caseNumber: ' + caseNumber);
            List<Case> caseList = [select id,caseNumber,status,isclosed,case.type,
                               case.contact.FirstName,case.contact.Email,contact.account.name,contact.account.owner.name,
                               contact.account.owner.email,contact.account.owner.username,contact.account.owner.profile.name 
                               from case where  case.Id=:caseNumber];
            if(!caseList.isEmpty() && caseList.size() > 0){
                for(Case caseRecord:caseList)
               {
            system.debug('caseRecord: ' + caseRecord);
            system.debug('case-->contact.Name: ' + caseRecord.Contact.Firstname);
            system.debug('case-->contact.email: ' + caseRecord.contact.Email);
            system.debug('case-->contact-->accont.name: ' + caseRecord.contact.account.name);
            system.debug('case-->contact-->account-->owner.username: ' + caseRecord.contact.account.owner.email);
            system.debug('case-->contact-->account-->owner-->profile.name: ' + caseRecord.contact.account.owner.profile.name);
                }
            }
        }
        
    }
    
    public static void getParentandChildRecordsByName(string actName)
    {
        if(actName != '' && actName !=null){
            system.debug('actName: ' + actName);
           List<Account> actList = [select id,name,phone,industry,(select id,Lastname,homephone,isprimary__C,Budget__C from contacts),
                                                                (select id,Name,isclosed,OrderNumber__C,budget__C from opportunities),
                                                                (select id,IsDeleted,status,priority,origin,type from cases)
                                                              from account where name=:actName];
            // system.debug('No of contacts: ' + actRecord.contacts.size());
            // system.debug('ContactList: ' + actRecord.contacts);
            // system.debug('No of Opportunities: ' + actRecord.opportunities.size());
            // system.debug('OppList: ' +  actRecord.opportunities);
            // system.debug('No Of Cases: ' + actRecord.cases.size());
            // system.debug('caseList: ' + actRecord.cases);
            if(!actList.isEmpty() && actList.size() > 0){
                for(Account actRecord: actList){
                    system.debug('actRecord: ' + actRecord);
                    system.debug('contacts record size: ' + actRecord.contacts.size());
                    
                    for(Contact conRecord: actrecord.contacts){
                        system.debug('contact Record: ' + conRecord);
                    }
                    system.debug('opprtunites record size: ' + actRecord.opportunities.size());
                    for(Opportunity optRecord: actRecord.opportunities){
                        system.debug('opt Record: ' + optRecord);
                    }
                    
                    system.debug('cases record size: ' + actRecord.cases.size());
                    for(Case caseRecord: actRecord.cases){
                        system.debug('opt Record: ' + caseRecord);
                    }
                    
                } 
            }
        }
        
    }
    
    public static void getLeadRecordsByEmailOrLastName(string searchString)
    {
        if(searchString != '' && searchString != null){
        system.debug('my searchString: ' + searchString);
            
        string LeadQuery = 'select id,FirstName,LastName,company,email,phone from lead where';
              if(Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}', searchString))
                {
                   system.debug('it is email id');
                    LeadQuery += ' Email=:searchString';
                    system.debug('LeadQuery' + LeadQuery);
                    
                }
                else
                {
                    system.debug('it is not email id');
                     searchString +='%';
                    system.debug('searchString: ' + searchString);
                    LeadQuery += ' Lastname like:searchString';
                    system.debug('LeadQuery: ' + LeadQuery);
                   
                 }
            
              List<Lead> LeadList = Database.query(LeadQuery);
              system.debug('Leads Count: ' + LeadList.size());
              system.debug('LeadList: ' + LeadList);
            system.debug('LeadList.isEmpty(): ' + LeadList.isEmpty());
              if(!LeadList.isEmpty() && LeadList.size() > 0){
             for(Lead LeadRecord:LeadList){
                system.debug('Lead Record: ' + LeadRecord);
            }
        }
       
        }
    }
    
    public static void getAllCandidatesByLocation(string Location)
    {
        if(Location != '' && Location != null ){
        string candidateQuery = 'select id,phone__C,email_id__C,name,notice_period__C,location__c from Candidate__c where Location__c =:Location';
        List<Candidate__c> canList = Database.query(candidateQuery);
        system.debug('candidate size: ' + canList.size());
        system.debug('canList: ' + canList);
            if(!canList.isEmpty() && canList.size() > 0){
                for(Candidate__c canrecord: canList){
                    system.debug('candidate record ' + canrecord);
                }
            }
        }
        
    }
    public static void getAllContactsByIndustryName(string industryName)
    {
        if(industryName!= null && industryName !=''){
        Map<Id,Account> mappaccountList = new Map<Id,Account>([select id,name,rating,industry from account where industry=:industryName]);
        system.debug('mappingaccountList: ' + mappaccountList.size());
        system.debug('mappingaccountList: ' + mappaccountList);
        system.debug('keyes:accountIds: ' + mappaccountList.keyset());
        system.debug('accountObjects: ' + mappaccountList.values());
            if(!mappaccountList.isEmpty())
            {
                List<Contact> contactList = [select id,name,phone,title from contact where accountId in:mappaccountList.keyset()];
                  system.debug('contactList: ' + contactList.size());
                if(!contactList.isEmpty())
                {
                    for(Contact conObj:contactList)
                    {
                        system.debug('Contact Record: ' + conObj);                        
                    }
                }
                }
                
                
            }
          
        }
        
    public static void getAllAccountsByStartingCharacter(string characterString)
    {
        system.debug('Character string: ' + characterString);
        if(characterString !=null && characterString !=''){
            characterString = characterString + '%';
        List<Account> actList = [select id,name,rating,phone,type,annualRevenue,Budget__c from account where name like: characterString];
        system.debug('actList size: ' + actList.size());
        system.debug('actList: ' + actList);
        if(!actList.isEmpty()){
        for(Account actObj:actList){
            system.debug('Account Record : ' + actObj);
        }
        }
      }
    }
}