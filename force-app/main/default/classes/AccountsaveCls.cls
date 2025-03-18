public class AccountsaveCls {
    public Account actObj{get;set;}
    public AccountsaveCls(){
        actObj = new Account();
    }
    
    public pageReference saveAccount(){
        insert actObj;
        System.debug('actObj@@: ' + actObj);
        return new pageReference('/'+ actObj.Id);
    }
}