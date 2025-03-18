public with sharing class BatchAPICalloutDemo implements Database.Batchable<sObject>,Database.allowsCallouts
{
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        system.debug('start method called');
        string q = 'select Id,Name,Rating,Industry from Account';
        return Database.getQueryLocator(q);

    }
    public void execute(Database.BatchableContext bc,List<Account> records)
    {
        system.debug('execute method called');
       
        try
        {
        YesNo yNObject = new YesNo();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('https://yesno.wtf/api');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug('response: ' + response);
        if(response.getStatusCode() == 200)
        {
            yNObject = (YesNo)JSON.deserialize(response.getBody(),YesNo.class);
            system.debug('yNObject: ' + yNObject); // YesNo:{answer=yes, forced=no,image=myImage}

        }
        else {
            system.debug('API callout failed: ' + response.getStatusCode());
        }
    }
    catch(Exception ex)
    {
        system.debug('ex: ' + ex);
        system.debug('message: ' + ex.getMessage());
        system.debug('Line: ' + ex.getLineNumber());

    }



    }
    public void finish(Database.BatchableContext bc)
    {
        // send email notification with failed records
        system.debug('finish method called');

    }
    
}