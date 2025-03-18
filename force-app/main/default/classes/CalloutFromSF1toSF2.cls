public with sharing class CalloutFromSF1toSF2 {
    

    public static void sendCalloutOrg2()
    {
        Http http = new Http();
        httpRequest request = new httpRequest();
         request.setEndpoint('callout:SecondOrgAccess/services/data/v62.0/sobjects/Account');
        // request.setEndpoint('https://ddl00000fotsluat-dev-ed.develop.my.salesforce.com/services/data/v62.0/sobjects/Account');
        request.setMethod('POST');
        request.setHeader('Content-type','application/json');
        request.setBody('{"Name":"namedcredential effect","Phone":909090,"AnnualRevenue":678}');
        HttpResponse response = http.send(request);
        System.debug('response: ' + response);
        if(response.getStatusCode()==201)
        {
            System.debug('record inserted in second org: ' + response.getBody());
        }
    }

    public static void getRecordsFromOrg2()
    {
        Http http = new Http();
        System.debug('http: ' + http); // System.http[]
        HttpRequest request = new HttpRequest(); // System.httpRequest[EndPoint=null,method=null]
        System.debug('request: ' + request);
       // request.setEndPoint('callout:SecondOrgAccess/services/data/v62.0/sobjects/Account/externalId__c/111');
       request.setEndPoint('callout:SecondOrgAccess/services/data/v62.0/sobjects/Account/001dL00000cozATQAY');

        request.setMethod('DELETE');
        // request.setHeader('Content-type','application/json');
       // string jsonString = '{"Name":"upsertRecord","Phone":7013948962,"AnnualRevenue":4500000}';
        // request.setBody(jsonString);
        System.debug('request1: ' + request);
        HttpResponse response = http.send(request);
        System.debug('response: ' + response); // system.httpResponse[status=ok,statusCode=200]
        System.debug('response body: ' + response.getBody());

    }
}