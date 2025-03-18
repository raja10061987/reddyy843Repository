public with sharing class RetriveAccounts {
    public Account actObj{get;set;}
    public RetriveAccounts() {
            actObj = new Account();
    }
    public pagereference saveRecord(){
        insert actObj;
        return new pagereference('/' + actObj.Id);
    }

}