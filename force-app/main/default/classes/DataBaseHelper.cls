public class DataBaseHelper {
    // create account record
    public static void createAccountRecord()
    {
        Account actObj = new account();
        actObj.Name = 'sumathi record';
        actObj.Rating = 'hot1';
        actObj.AccountSource = 'web';
        actObj.Active__c = 'true';
        actObj.BillingCity = 'hyderabad';
        actObj.Fax ='213432';
        actObj.Phone = '8309351867';
        insert actObj;
        if(actObj.Id != null)
        {
            system.debug('account record created successfully...' + actObj.Id);
        }
    }
    // create case record
    
    public static void createCaseRecord()
    {
        Case caseobj = new case();
        caseobj.status = 'new';
        caseobj.Origin = 'Phone';
        caseObj.Type = 'Other';
        caseObj.SLAViolation__c = 'yes';
        caseObj.Reason = 'Installation';
        caseObj.Subject = 'program subject';
        caseObj.Description = 'this program is doing installation susscessfully';
        insert caseObj;
        if(caseObj.id != null){
            system.debug('case record created successfully....' + caseObj.Id);
        }
                
    }
    
    // create hiring manager record and related position record
    public static void createHiringmanagerRecord()
    {
        hiring_manager__C obj = new hiring_manager__C();
        obj.Name = 'suknya manager';
        obj.Designation__c = 'sukanya developer';
        obj.Email_Id__c = 'annapureddy.reddy04@infosys21.com';
        obj.Location__c = 'bangalore one';
        obj.Contact_Number__c = '8309351867';
        insert obj;
        if(obj.Id != null){
            for(integer counter = 1;counter <=5;counter++){
            system.debug('hiring manager record created successrfully  ' + obj.Id);
            Position__c pObj = new Position__c();
            pObj.Name = 'vlocity developer- ' + counter ;
            pObj.Location__c = 'Hyderabad';
            pobj.Number_Of_Vacancies__c = 10;
            pObj.Position_Status__c = 'New Position';
            pObj.Minimum_Pay__c = 23000;
            pObj.Maximum_Budget__c = 2300000;
            pObj.Open_date__c = system.today() -1;
            pObj.MileStone_Date__c = system.today() + 10;
            pObj.Travel_Required__c = true;
            pObj.Passport_Required__c = true;
            pobj.Skills_Required__c = '.net;java;php;angular;10 yrs experiecnce on salseforce developer';
            pObj.HR_Email_ID__c = 'hr@infosys.com';
            pObj.HR_Contact_Number__c = '1243534';
            // position record is related to the hiring manger
            pObj.Hiring_Manager_Id__c = obj.Id;
            insert pObj;
            system.debug('position record created successfully:  ' + pObj.Name + pObj.Id);
         }
        }
        
        
    }
    
    // create account related contact record
    public static void createAccountrelatedcontactrecord()
    {
        Account actObj = new Account();
        actObj.Name = 'new pavn123';
        actObj.Rating = 'Hot';
        actObj.Active__c = 'yes';
        actObj.AnnualRevenue = 2000;
        actObj.BillingCity = 'hyderabad1';
        actObj.Budget__c = 5000;
        actObj.Industry = 'sulthan';
        actObj.Fax = '123247';
        insert actObj;
        if(actObj.id != null)
        {
            system.debug('account is created successfully: ' + actObj.id);
            // insert contact record
            case caseObj = new case();
            caseObj.Origin = 'Email';
            caseObj.Comments = 'this is a new case;please close it ASAP';
            caseObj.Status = 'New';
            caseObj.AccountId = actObj.id;
            insert caseObj;
            system.debug('opportunity record created successfully: ' + caseobj.Id);
        }
        
        
    }
    
    // create the multiple candidates
    public static void createBulkCandidates(integer maxRecords)
    {
        if(maxRecords > 0)
        {
            for(integer counter = 1; counter <=maxrecords;counter++)
            {
                candidate__c cObj = new Candidate__c();
                cObj.Name = 'chakravarthy - ' + counter;
                cObj.Phone__c = '8309351867';
                cObj.Email_id__c = 'reddyy843@gmail.com';
                cObj.Notice_period__c = '1 month';
                cobj.Location__c = 'bangalore' + counter;
                cObj.Passport_required__c = true;
                cObj.Experience__c = 10;
                cObj.current_CTC__c = 1200000;
                cObj.Expected_CTC__c = 2400000;
                cobj.skills__c = 'java;oracle;salesforce';
                cObj.Position__c = 'a045g0000036zQrAAI';
                insert cObj;
                if(cobj.Id != null)
                {
                    system.debug('candidate name: ' + cObj.Name + '  candidate id: ' + cobj.Id);
                }
                
            }
            
        }
        
    }
    
    // create the position and related contact records
    
    public static void createpositionrelatedchildrecords(integer maxCandidateRecords)
    {
        // create position record
        
        position__c pObj = new position__c();
        pObj.Name = 'senior salesforce developer';
        pObj.Location__c = 'Bangalore';
        pObj.Number_Of_Vacancies__c = 10;
        pObj.MileStone_Date__c = system.today() + 10;
        pObj.HR_Email_ID__c = 'reddyy843@salesforce.com';
        pObj.Open_date__c = system.today();
        pObj.Maximum_Budget__c = 230000;
        insert pObj;
        if(pObj.id != null){
            system.debug('position record created successfully: '+ pObj.Name + pObj.Id);
        }
        if(maxCandidateRecords > 0)
        {
             for(integer counter=0;counter <=maxCandidateRecords;counter++)
             {
                   // create the candidate record
                 Candidate__c cObj = new candidate__c();
                 cObj.Name = pObj.Name + ' ' + counter;
                 cObj.Email_id__c = pObj.HR_Email_ID__c;
                 cObj.Notice_period__c = 'Immediate';
                 cObj.Experience__c = 10;
                 cObj.Expected_CTC__c = 2500000;
                 cObj.Phone__c = '7898970788';
                 cObj.skills__c = 'java;net;python;azure;salesforce';
                 cobj.Position__c = pobj.Id;
                  insert cObj;
            
             }
        }
       
      
        
    }
    
}