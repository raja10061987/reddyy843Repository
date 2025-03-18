Global with sharing class UpdateContacts1Batch implements Database.Batchable<sObject>
{
    Global Database.QueryLocator start(Database.BatchableContext bc)
    {
      return Database.getQueryLocator('select id from Contact where UnSubScribe_Date__c < today');
    }
    Global void Execute(Database.BatchableContext bc,List<SObject> contList)
    { // (Contact:{id=ajhscbah,DoNotCall__c=true,HasOptedOutEmail__c=true,HasOptedOutOfFax__c=true},Contact:{id=asjhdah})
        for(SObject contact:contList)
        {
          contact.put('DoNotCall__c', false);
          contact.put('HasOptedOutEmail__c', false);
          contact.put('HasOptedOutOfFax__c', false);
        }
        update contList;

    }
    public void finish(Database.BatchableContext bc)
    {
       System.debug('batch class processed successfully');
    }
    
}