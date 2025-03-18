global with sharing class MyWebService 
{
   webservice static string accountContact(string name,boolean isAccount)
    { // if you decorate this method as webservice, this class will consider as a APEX SOPAP API class.
        System.debug('account Name: ' + name);
        System.debug('isAccount: ' + isAccount);
        if(isAccount)
        {
            Account actObj = new Account();
            actObj.Name = name;
            actObj.Phone = '1223445';
            actObj.Rating = 'Hot';
            actObj.AnnualRevenue =  9000;
            insert as user actObj;
            System.debug('after inserting account: ' + actObj);
            return actObj.Id;

        }
        else {
               Contact contObj = new Contact();
               contObj.LastName = name;
               insert as user contObj;
               System.debug('after inserting Contact: ' + contObj);
               return contObj.Id;
        }
    }


     webservice static string opportunityCreate(string name,string stageName)
    {
        System.debug('opportunity create');
         
         Opportunity optObj = new Opportunity();
        System.debug('optObj: ' + optObj); // {}
        optObj.Name = 'Test opty1';
        optObj.StageName = 'Prospecting';
        optObj.CloseDate = system.today().addDays(10);
         insert optObj;
         System.debug('after inserting optObj:'  + optObj);
        return optObj.Id;
    }
   
    
}