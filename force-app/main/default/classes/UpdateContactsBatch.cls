public with sharing class UpdateContactsBatch implements Database.Batchable<SObject>
{
    public UpdateContactsBatch() {

    }
    // 50 million records
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
     return Database.getQueryLocator('SELECT id from Contact where UnSubScribe_Date__c < today');
    }
    // 20000 /200 ==> 10 batches
    // each batch 200 records 200 * 10 == 2000
    // max batch size: 20000
    public void Execute(Database.BatchableContext bc, List<Contact> conatsList)
    {// (Contact:{id=asjkdhak},Contact:{id=askjdba})
        List<Contact> contactsToUpdate = new List<Contact>();
         for(Contact eachContact:conatsList)
         {
            eachContact.DoNotCall__c = false;
            eachContact.HasOptedOutEmail__c = false;
            eachContact.HasOptedOutOfFax__c	 = false;
            // contactsToUpdate.add(eachContact);
         }
         System.debug('Execute: conatsList: ' + conatsList); // (Conatct:{id=asbdan,DoNotCall__c=true,HasOptedOutEmail__c=true,HasOptedOutOfFax__c=true},Contact:{})
         update conatsList;
       
    }

    public void finish(Database.BatchableContext bc)
    {
       System.debug('finish method called');
    }

}