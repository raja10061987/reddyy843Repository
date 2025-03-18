public class MixedError 
{
    public static void DoDMLOperation(string username,string actName)
    {
        User userRecord = [select id,username,isactive,alias from user 
                                                  where username=:username limit 1];
        
        if(userRecord.id != null){
            userRecord.alias = 'dev1';
           // userRecord.IsActive = false;
            // set up object update
            update userRecord;
            system.debug('user record updated successfully');
        }
           MixedError.futuremethod(actName);
        
        }
    @future
    public static void futuremethod(string actName)
    {
        
        Account actRecord = [select id,name,phone,active__c,annualrevenue 
                             from account 
                             where name=:actName limit 1];
       
         actRecord.AnnualRevenue = 77000;
            // non set up object
          update actRecord;
         system.debug('account record updated successfully');
       
        
    }
    
    }