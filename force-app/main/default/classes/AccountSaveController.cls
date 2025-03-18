public with sharing class AccountSaveController 
{
    public Account actObj {get;set;}
    public List<String> fieldsList {get;set;}

    public AccountSaveController()
    {
        actObj = new Account();
        fieldsList = new List<String>();
        for(Schema.FieldSetMember field: sObjectType.Account.FieldSets.Account_Fields.getFields())
        {
            fieldsList.add(field.getFieldPath());
        }
        system.debug('fieldsList: ' + fieldsList); // (Rating,Industry,Name)
    }
    public pageReference saveAccount()
    {
        System.debug('actObj: ' + actObj);
        insert as user actObj; // Account: {Name=pavan,Rating=Hot,Phone=122}
        return new pageReference('/' + actObj.Id);
    }
}