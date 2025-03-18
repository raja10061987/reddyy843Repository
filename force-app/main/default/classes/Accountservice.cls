@RestResource(urlMapping='/AccountRecord/*')
Global with sharing class Accountservice 
{   @HttpGet
    global static void getAccountById()
    {
        string jsonString;
        string accountId = RestContext.request.params.get('accountId');
        Account actObj = [select id,name,type,industry from account where id=:accountId WITH SECURITY_ENFORCED];
         jsonString = JSON.serialize(actObj);
         System.debug('jsonString: ' + jsonString);
        RestContext.response.addHeader('Content-Type','application/json');
        RestContext.response.responseBody = Blob.valueOf(jsonString);
        System.debug('RestContext.response: ' + RestContext.response);
    }

}