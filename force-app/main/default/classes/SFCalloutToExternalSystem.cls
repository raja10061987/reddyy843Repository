public with sharing class SFCalloutToExternalSystem {
    @future(callout=true)
    public static void makeCallout()
    {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:UserNamedCredential/api/user');  // https://reqres.in
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        System.debug('response: --'+res); // System.httpResponse[status = ok, statusCode=201]
        System.debug('response body: --'+res.getBody()); 

    }

    @future(callout=true)
    public static void makeCalloutPostMethod()
    {
       Http http = new Http();
       HttpRequest req = new HttpRequest();
       req.setEndPoint('https://reqres.in/api/users');
       req.setMethod('POST');
       req.setHeader('Content-Type', 'application/json');
       req.setBody('{"name": "Testing Apex using Parameters","job": "Testing Apex job"}');
       HttpResponse response = http.send(req);
       System.debug('response: --'+response); 
       System.debug('response body: --'+response.getBody());
    }

    public static void makeOAutCallout()
    {

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:secondOrgCredential/services/data/v62.0/sobjects/Account');
        // req.setEndpoint('callout:secondOrgCredential/services/data/v62.0/sobjects/Account');  //Request Endpoint
        req.setMethod('GET');
        // string body = '{"Name":"Testing record","Phone":"1234567890","AnnualRevenue": 9000}';
        // req.setBody(body);
        System.debug('request: ' + req);
        HttpResponse response = http.send(req);
        System.debug('Response: --'+response);
    }

}