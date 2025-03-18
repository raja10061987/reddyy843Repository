@RestResource(urlMapping='/accountAPI/*')
global with sharing class AccountResource 
{
    @HttpGet
   global static List<Account> getAccounts()
   {
       RestRequest contactRestContext = RestContext.request;
       system.debug('contactRestContext: ' + contactRestContext);
        string contRequestURI = contactRestContext.requestURI;
       system.debug('contRequestURI: ' + contRequestURI);// /accountAPI/5
       integer indexposition = contRequestURI.lastIndexOf('/') + 1;
       system.debug('indexposition: ' + indexposition);
        integer accountLimit = Integer.valueOf(contRequestURI.substring(indexposition));  
       system.debug('accountLimit: ' + accountLimit);
      List<Account> actList = [select id,name,phone,Rating from account limit:accountLimit];
       system.debug('actList: ' + actList);
       return actList;
       
   }
    
    
    global static account upsertAccount(string accountName,string AccountNumber,string Rating,string type,string Industry)
    {
        restRequest accountContext = restContext.request;
        system.debug('accountContext: ' + accountContext);
        string accountRequestURI = accountContext.requestURI;  // /accountAPI/0015g00000bprRB
        string accountId = accountRequestURI.substring(accountRequestURI.lastIndexOf('/') + 1);
        system.debug('accountId: ' + accountId);
        system.debug('AccountNumber: ' + AccountNumber);
        system.debug('type: ' + type);
        system.debug('Industry: ' + Industry);
        system.debug('Rating: ' + Rating);
        system.debug('accountName: ' + accountName);
        
        Account actObj = new account();
        
        if(String.isNotEmpty(accountId)) // if id is present
        {
            actObj.id = accountId;
        }
        
        actObj.AccountNumber = AccountNumber;
        actObj.Type = type;
        actObj.Industry = Industry;
        if(Rating != null && accountName != null)
        {
           actObj.Rating = Rating;  
            actObj.Name = accountName;
        }
        
        system.debug('actObj: ' + actObj);
        
        upsert actObj;
        return actObj;
    }
    
    @HttpPut
    global static Hiring_Manager__c upsertHRRecord(string name,string location,string emailId,string ContactNumber,string Designation)
    {
        restRequest hrContextRequest = restContext.request;
        string hrRequestURI = hrContextRequest.requestURI; ///accountAPI/a085g000005cXwL
        string hrId = hrRequestURI.substring(hrRequestURI.lastIndexOf('/') + 1);
        system.debug('hrId: ' + hrId);
        system.debug('name: ' + name);
        system.debug('location: ' + location);
        system.debug('emailId: ' + emailId);
        system.debug('ContactNumber: ' + ContactNumber);
        system.debug('Designation: ' + Designation);
        
        Hiring_Manager__c	 hrObj = new Hiring_Manager__c();
        
        if(String.isNotBlank(hrId))
        { // while updating
            system.debug('updating block');
            hrObj.Id = hrId;        
        }
                     
        if(string.isEmpty(emailId) || String.isEmpty(ContactNumber))
        {
            system.debug('email id and contact number blank');
            hrObj.Email_Id__c = 'defaultemail@gmail.com';
            hrObj.Contact_Number__c = '8308351867';
        }
        else
        {
            hrObj.Email_Id__c = emailId;
            hrObj.Contact_Number__c = ContactNumber;
        }
        hrObj.Name = name;
        hrObj.Location__c = location;
        hrObj.Designation__c = Designation;
        system.debug('hrObj: ' + hrObj);
        
        upsert hrObj;
        return hrObj;
        
        
    }

}