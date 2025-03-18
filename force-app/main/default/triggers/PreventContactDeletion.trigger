trigger PreventContactDeletion on Contact (before insert,after insert,before update, after update, before delete) {
    if(trigger.isdelete && trigger.isbefore){
    for(Contact contObj:trigger.old){
        if(contObj.isprimary__C){
            contObj.addError('you cannot delete primary contacts');
        }
    }
    AccountActionHandler.calculateNoOfContactsOndelete(trigger.Old);
    }    
   if(trigger.isUpdate && trigger.isAfter){
        contacttriggerhandler1.createCase(trigger.newMap,trigger.oldMap);
    }
    
    if(trigger.isinsert && trigger.isbefore){
    
        // Trigger.New[0].LastName = Trigger.New[0].LastName + ' raja';
        // system.debug('Trigger.New[0]: ' + Trigger.New[0]);
        
        for(Contact contObj:Trigger.New)
        {
          contObj.LastName = contObj.LastName + 'updated through trigger';
        }
        system.debug('Trigger.New:@@ ' + Trigger.New);
       // AccountActionHandler.createPrimaryContactsOncreate(trigger.new);
    }
    // if(trigger.isUpdate && trigger.isBefore){
    //     AccountActionHandler.preventPrimaryContactOnUpdate(trigger.newMap,trigger.oldMap);
    // }

    if(trigger.isBefore && trigger.isUpdate)
    {
        AccountActionHandler.beforeUpdatePreventPrimaryContact(trigger.newMap,trigger.oldMap);
    }

    if(trigger.isAfter && trigger.isInsert){
        AccountActionHandler.calculateNoOfContactsOnCreate(trigger.New);
    }

    if(trigger.isBefore && trigger.isInsert)
    {
        AccountActionHandler.beforeInsertPreventPrimaryContact(trigger.New);

    }
   
    
}