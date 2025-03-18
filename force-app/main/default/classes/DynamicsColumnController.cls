public with sharing class DynamicsColumnController 
{
    public List<Account> actList {get;set;}
    public DynamicsColumnController() 
    {
        actList = new List<Account>();

        string soqlQuery = string.escapeSingleQuotes('select ');

        for(Schema.FieldSetMember fMember:sObjectType.Account.FieldSets.Account_Fields.getFields())
        {
            soqlQuery += string.escapeSingleQuotes(fMember.getFieldPath()) + string.escapeSingleQuotes(',');

        }
        soqlQuery = soqlQuery.removeEnd(',');
        system.debug('soqlQuery: ' + soqlQuery);
        soqlQuery = soqlQuery +  string.escapeSingleQuotes(' from ') + string.escapeSingleQuotes('Account');
        system.debug('final query: ' + soqlQuery);
        
        actList = Database.query(soqlQuery);
        system.debug('actList size: ' + actList.size());
        system.debug('actList: ' + actList);

    }
}