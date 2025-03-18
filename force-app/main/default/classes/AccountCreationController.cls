public class AccountCreationController {
   public Account actObj {get;set;}
    public AccountCreationController(){
        actObj = new Account();
    }
    public  pagereference saveAccount(){
        insert as user actObj;
         return new pagereference('/' + actObj.Id);
    }

    @AuraEnabled
    public static Account insertAccountRecord(Account actObj){
        try 
        {
        System.debug('actObj: ' + actObj);
         insert as user actObj;
         return actObj;   
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

      @AuraEnabled
      public static void createAccounts(List<Account> actList)
       {
          System.debug('before inserting actList:: ' + actList);
       try 
       {
             if(actList.size() > 0)
             {
                insert as user actList;
                System.debug('after inserting actList: ' + actList);
             }
        } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
       }
      }

}