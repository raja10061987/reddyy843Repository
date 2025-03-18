public with sharing class RestAPICallout 
{

    public static void makeAPICallout()
    {

        // get users

        // Http http = new Http();
        // HttpRequest req = new HttpRequest();
        // req.setEndpoint('https://reqres.in/api/users?page=2');
        // req.setMethod('GET');
        // System.debug('request: ' + req); // System.httpRequest[EndPoint=https://reqres.in/api/users?page=2,Method=GET]
        // HttpResponse response = http.send(req);
        // System.debug('response: ' + response); // System.htttpResponse[Status=OK,StatusCode=200]
        // if(response.getStatusCode() == 200)
        // {
        //     System.debug('response.body: ' + response.getBody());
        //     Map <String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        //     System.debug('results: ' + results);
        //     Object dataList = results.get('data');
        //     System.debug('dataList: ' + dataList);


        // }
        // else {
        //     System.debug('API callout failed');
        // }

        // create users

        Http http = new Http();
        System.debug('Http: ' + http);
        HttpRequest req = new HttpRequest();
        System.debug('req: ' + req);
        req.setEndpoint('https://reqres.in/api/users');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"name": "morpheus", "job": "leader"}');
        System.debug('request: ' + req);
        HttpResponse res = http.send(req);
        System.debug('res: ' + res);
        if(res.getStatusCode() == 201)
        {
            System.debug('response: ' + res.getBody());
        }
    }
    
}