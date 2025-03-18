trigger AccountInsert on Account (after insert,before insert,after update) {
    //if(Trigger.Isinsert && Trigger.isAfter)
      // {
    //AccountActionHandler.createcontacts(Trigger.New);
        //}
     CustomFlag__c customObj = customFlag__c.getInstance(UserInfo.getUserId());
    if(trigger.isUpdate && Trigger.isAfter && customObj.isFlag__c){
        AccountActionHandler.createOpportunities(Trigger.NewMap,Trigger.oldMap);
         
    }  
   
    }