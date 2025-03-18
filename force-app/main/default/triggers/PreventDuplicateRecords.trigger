trigger PreventDuplicateRecords on Candidate__c (before insert,before update) 
{
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
    {
        for(candidate__c canObj:trigger.new){
            system.debug('can record name: ' + canObj.Name);
            integer canRecordCount = [select  count() from candidate__c where name=:canObj.Name];
            if(canRecordCount > 0)
            {
                canObj.addError('we have candidate record with same name: ' + canObj.Name + ' duplicate records are not allowed');
            }
        }
        
    }

}