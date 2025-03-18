public class AccountActionHandler {



      public static void updateUserRole()
      {
        

           Account_Creation_Event__e	 evntObj = new Account_Creation_Event__e();
     evntObj.Account_Name__c = 'raja';
    evntObj.AccountId__c	 = '001hagcac';
    evntObj.Error_Description__c	 = 'hello error1';
    evntObj.Phone__c = '111111';
    System.debug('evntObj: ' + evntObj);
    Database.SaveResult result = EventBus.publish(evntObj);
    System.debug('result: ' + result);
    if(result.isSuccess())
    {
      System.debug('platform event published successfully');

    }
    else {
        for (Database.error errorObj : result.getErrors()) {
            System.debug('error message: ' + errorObj.getMessage());
            System.debug('error status code: ' + errorObj.getStatusCode());
            System.debug('error fields' + errorObj.getFields());
          
        }
    }
      }

  public static void accountAfterInsert(List<Account> actsList)
  {

    
Opportunity optObj = new opportunity();
optObj.Name = 'test opt';
optObj.StageName = 'Prospecting';
optObj.CloseDate = system.today();
insert optObj;
System.debug('myOptObj: ' + optObj);

    Account_Creation_Event__e	 evntObj = new Account_Creation_Event__e();
     evntObj.Account_Name__c = optObj.Name;
    evntObj.AccountId__c	 = optObj.Id;
    evntObj.Error_Description__c	 = 'hello error1';
    evntObj.Phone__c = '111111';
    System.debug('evntObj: ' + evntObj);
    Database.SaveResult result = EventBus.publish(evntObj);
    System.debug('result: ' + result);
    if(result.isSuccess())
    {
      System.debug('platform event published successfully');

    }
    else {
        for (Database.error errorObj : result.getErrors()) {
            System.debug('error message: ' + errorObj.getMessage());
            System.debug('error status code: ' + errorObj.getStatusCode());
            System.debug('error fields' + errorObj.getFields());
          
        }
    }
    

  }
    @InvocableMethod(label='Create contacts' description='Create the contacts for the account')
    public static void CreateContactsfortheaccounts(List<Account> accountList){
      List<Contact> contactList = new List<Contact>();
      for(Account actObj: accountList){
         Contact conObj = new Contact();
         conObj.accountId = actObj.Id;
         conObj.LastName = actObj.Name;
         conObj.HomePhone  = actObj.Phone;
         contactList.add(conObj); 
      }
      if(contactList != null && contactList.size() > 0){
          insert contactList;
      }

    }
    
    public static void createOpportunities(map<id,Account> newaccountMapList,map<id,account> oldaccountMapList){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account actObj:newaccountMapList.values()){
            if(newaccountMapList.get(actObj.Id).industry != oldaccountMapList.get(actObj.Id).Industry && newaccountMapList.get(actObj.Id).industry == 'Insurance'){
                  Opportunity opObj = new Opportunity();
                  opObj.AccountId = actObj.Id;
                  opObj.Name = actObj.Name;
                  opObj.CloseDate = system.today();
                  opObj.StageName = 'my stage';
                  oppList.add(opObj);
            }
            if(!oppList.isEmpty()){
                insert oppList;
            }
            }
    }

    public static void createPrimaryContactsOncreate(List<Contact> contactList){
        set<Id> existingAccountIds = new set<Id>();
        Map<Id,Contact> accountIdContactmapping = new map<Id,Contact>();
        for(Contact conObj:contactList ){
         if(conObj.isprimary__C == true && conObj.AccountId != null){
            existingAccountIds.add(conObj.AccountId);
         }
        } 
        if(existingAccountIds != null && existingAccountIds.size() > 0){
           for(Contact conObj: [select id,name,isprimary__C,AccountId from Contact where AccountId in: existingAccountIds and isprimary__C = true]){
            accountIdContactmapping.put(conObj.AccountId,conObj);
           }
        }
        for(Contact conObj: contactList){
          if(conObj.isprimary__C == true && conObj.AccountId != null && accountIdContactmapping.get(conObj.AccountId) != null){
            conObj.addError('you can \'t able to add primary contatcts');
          }
        }

    }

//     public static void preventPrimaryContactOnUpdate(map<id,Contact> newContacts,map<id,Contact> oldContacts){
//       set<Id> existingAccountIds = new set<Id>();
//       Map<Id,Contact> accountIdContactmapping = new Map<Id,Contact>();
//        for(Contact conObj:newContacts.values()){
//              if (newContacts.get(conObj.Id).AccountId != null && newContacts.get(conObj.Id).isprimary__C != oldContacts.get(conObj.Id).isprimary__C && newContacts.get(conObj.Id).isprimary__C == true){
//                 existingAccountIds.add(newContacts.get(conObj.Id).AccountId);
//              }
//        }
      
//        if(existingAccountIds != null && existingAccountIds.size() > 0){
//         for(Contact conObj: [select id,name,isprimary__C,AccountId from Contact where AccountId in: existingAccountIds and isprimary__C = true]){
//          accountIdContactmapping.put(conObj.AccountId,conObj);
//         }
//        }
//        for(Contact conObj:newContacts.values()){
//         if (newContacts.get(conObj.Id).AccountId != null && newContacts.get(conObj.Id).isprimary__C != oldContacts.get(conObj.Id).isprimary__C && newContacts.get(conObj.Id).isprimary__C == true
//         && accountIdContactmapping.get(newContacts.get(conObj.Id).AccountId) != null){
//             conObj.addError('you cannot add more than  one contact as primary');
//         }
//   }
// }

public static void calculateNoOfContactsOnCreate(List<Contact> contactList){
   set<Id> accountIdset = new set<Id>();
   map<Id,Account> mapaccountObj = new map<Id,Account>();
   for(Contact conObj:contactList){
     if(conObj.AccountId != null){
        accountIdset.add(conObj.AccountId);
     }
   }

   if(accountIdset != null && accountIdset.size() > 0){
    for(AggregateResult aggrresult: [select count(id)  countOfcontacts,accountId AccountId  from Contact 
                                            where accountId in: accountIdset group by accountId]){
    Account actObj = new Account();
    actObj.Id = (Id)aggrresult.get('AccountId');
    actObj.No_Of_Contacts__c = (integer)aggrresult.get('countOfcontacts');
    mapaccountObj.put(actObj.Id,actObj);
     
    }
   }
   if(mapaccountObj != null && mapaccountObj.size() > 0){
        update mapaccountObj.values();
   }
}


 public static void calculateNoOfContactsOndelete(List<Contact> contactList){
    set<Id> accountIdset = new set<Id>();
    Map<Id,Account> mappingAccountObj = new Map<Id,Account>();
    for(Contact conObj: contactList){
        if(conObj.accountId != null){
            accountIdset.add(conObj.accountId);
        }
    }

    if(accountIdset != null && accountIdset.size() > 0){
      for(AggregateResult aggrresult: [select count(id) countOfcontacts,accountId AccountId from Contact 
                                       where accountId in: accountIdset and id not in: contactList group by accountId]){
          
            Account actObj = new Account();
            actObj.Id = (Id)aggrresult.get('AccountId');
            actObj.No_Of_Contacts__c = (integer)aggrresult.get('countOfcontacts');
            mappingAccountObj.put(actObj.Id,actObj);                              
        
      }
    }
    if(mappingAccountObj != null && mappingAccountObj.size() > 0){
          update mappingAccountObj.values();
    }
    
}


public static void beforeUpdatePreventPrimaryContact(Map<Id,Contact> newContactMap, Map<Id,Contact> oldContactMap)
{
  system.debug('newContactMap: ' + newContactMap); // {0331983283= Contact: {Id=0331983283,Name=suman,isPrimary__C=true,AccountId=0111shhas}}
  system.debug('oldContactMap: ' + oldContactMap); // {0331983283= Contact: {Id=0331983283,Name=suman,isPrimary__C=false,AccountId=0111shhas}}
   system.debug('newContactMapkeyset: ' + newContactMap.keyset()); // {0331983283}
   set<Id> accountIds = new set<Id>(); // {}
   Map<Id,Contact> accountWithContactsMap = new Map<Id,Contact>();
   for(Id contactId:newContactMap.keyset())
   {
    Contact newContact = newContactMap.get(contactId);
    Contact oldContact = oldContactMap.get(contactId);
    system.debug('newContact: ' + newContact); // Contact: {Id=0331983283,Name=suman,isPrimary__C=true,AccountId=0111shhas}
    system.debug('oldContact: ' + oldContact); // Contact: {Id=0331983283,Name=suman,isPrimary__C=false,AccountId=0111shhas}

    if(newContact.isPrimary__C != oldContact.isPrimary__C && newContact.isPrimary__C == true && newContact.AccountId != null)
    {
      accountIds.add(newContact.AccountId);
    }
  }
    system.debug('accountIds: ' + accountIds); // {0111shhas}

         if(accountIds != null && accountIds.size() > 0)
         {
          List<Contact> contList = [select Id,Name,isPrimary__C,AccountId from Contact where isPrimary__C = true and accountId in:accountIds WITH SECURITY_ENFORCED];
          system.debug('existing primary contatctList: ' + contList);
          for(Contact contObj:contList)
          {
            accountWithContactsMap.put(contObj.AccountId,contObj); // {0111shhas =  Contact: {Id=0331983283,Name=suman,isPrimary__C=true,AccountId=0111shhas}}

          }

          system.debug('accountWithContactsMap: ' + accountWithContactsMap); 

          for(Contact contObj: newContactMap.values())
          {
            Contact newContact1 = newContactMap.get(contObj.Id);
            Contact oldContact1 = oldContactMap.get(contObj.Id);
            if(newContact1.isPrimary__C != oldContact1.isPrimary__C && newContact1.isPrimary__C == true && newContact1.AccountId != null && accountWithContactsMap.get(newContact1.AccountId) != null)
            {
              contObj.addError('you can\'t update more than one primary conatct');

            }

          }

         }

}


public static void beforeInsertPreventPrimaryContact(List<Contact> neContact)
{
  system.debug('neContact: ' + neContact); // (Contact: {Id=0033333,Name=suma,isPrimary__C = True,AccountId=0111chs})
set<Id> actIdsSet = new Set<Id>(); // {}
Map<Id,Contact> accountIdWithContatcts = new Map<Id,Contact>();
  for(Contact contObj: neContact)
  {
    if(contObj.IsPrimary__c == true && contObj.AccountId != null)
    {
      actIdsSet.add(contObj.AccountId);	

    }
    system.debug('actIdsSet: ' + actIdsSet); // {0111chs}
    
  }

  if(actIdsSet != null && actIdsSet.size() > 0)
  {
    List<Contact> contList = [select Id,Name,isPrimary__C,AccountId from Contact where isPrimary__C = true AND accountId in: actIdsSet WITH SECURITY_ENFORCED];
    system.debug('existing contactsList: ' + contList);
    for(Contact contObj:contList){
      accountIdWithContatcts.put(contObj.AccountId,contObj);
    }
    system.debug('accountIdWithContatcts: ' + accountIdWithContatcts); // {01111=Contact:{Id=0333,isPrimary__c=true,AccountId=0111}}

    for(Contact contObj: neContact)
  {
    if(contObj.isPrimary__C == true && contObj.AccountId != null && accountIdWithContatcts.get(contObj.AccountId) != null)
    {
     contObj.addError('can\'t insert more than one primary Contact');

    }
  
  }


  }

}


}