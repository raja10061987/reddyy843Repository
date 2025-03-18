trigger AutoPopulateAnnualRevenue on Account (before insert,before update,before delete,after update) {
  // system.debug('trigger starting point');
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
    {
       // system.debug('isBefore: ' + trigger.isBefore);
        // system.debug('isInsert: ' + trigger.isinsert);
        // system.debug('isUpdate: ' + trigger.isUpdate);
        
        // List<Account> newAccountList = trigger.new;
       // system.debug('newAccountList: ' + newAccountList);
       AutoPopulateAccountAnnualRevenue.AccountAnnualRevenue(trigger.new);
        
        
    }
    
    if(trigger.isBefore && trigger.isDelete)
    {
        system.debug('isBefore: ' + trigger.isBefore);
        system.debug('isDelete: ' + trigger.isDelete);
        List<Account> actList = trigger.old;
      //   system.debug('actList: '+ actList);
         AutoPopulateAccountAnnualRevenue.preventDeleteionActiveAccountRecords(trigger.old);
         Map<Id,Account> mapactList = trigger.oldMap;
         set<Id> actIdList = mapactList.keySet();
        // system.debug('actIdList: ' + actIdList);
        AutoPopulateAccountAnnualRevenue.preventdeletionContacts(actIdList);
       
    }
    
    if(trigger.isAfter && trigger.isUpdate )
    {
        system.debug('account isAfter: ' + trigger.isAfter);
        system.debug('account isUpdate: ' + trigger.isUpdate);
         Map<Id,Account> mapactIdList = trigger.newMap;
          set<Id> actidList = mapactIdList.keySet();
        AutoPopulateAccountAnnualRevenue.synchronizAccountPhoneTax(actidList);
        
        
        
    }
}