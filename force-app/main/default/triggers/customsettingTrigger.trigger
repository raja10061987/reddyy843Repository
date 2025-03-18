trigger customsettingTrigger on Case (before insert) {
 Capital__c c = capital__c.getInstance(userInfo.getUserId());
    if(c.Flag__c == true){
        for(Case cObj: trigger.New){
           cObj.Subject = 'subject is updated through trigger';
            
        }
        
    }
}