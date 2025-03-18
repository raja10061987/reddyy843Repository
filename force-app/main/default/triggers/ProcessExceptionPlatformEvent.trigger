trigger ProcessExceptionPlatformEvent on Exception_Log__e (after insert) 
{
    List<Exception__c> exceptionsList = new List<Exception__c>();
    List<Exception_Log__e> exceptionLogs = trigger.New;
    system.debug('exceptionLogs: ' + exceptionLogs);
    // (Exception_Log__e: {Object__C=Account,Operation__C=failed,recordId__C=00162,Exception_Details__c=details},Exception_Log__e: {})

    for(Exception_Log__e exObj:exceptionLogs)
    {
        Exception__c myErrorObj = new Exception__c();
        myErrorObj.Object__c = exObj.Object__c;
        myErrorObj.recordId__c = exObj.recordId__c;
        myErrorObj.Exception_Details__c = exObj.Exception_Details__c;
        myErrorObj.Operation__c  = exObj.Operation__c;
        exceptionsList.add(myErrorObj);

    }
    system.debug('exceptionsList size: ' + exceptionsList.size());
    system.debug('exceptionsList: ' + exceptionsList);
    if(exceptionsList.size() > 0)
    {
        insert  exceptionsList;

    }

}