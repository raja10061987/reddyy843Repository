public with sharing class BlogsContinutionController 
{
    public HTTPCalloutAsyncService service {get;set;}
    public List<string> requestLabels;
    public BlogsContinutionController() {

    }
    public class Record
    {
        public string id {get;set;}
        public string title {get;set;}
        public string url {get;set;}
    }
    public class blogswrapper
    {
        public string author {get;set;}
        public List<Record> blogs {get;set;}

    }
    public class appsWrapper
    {
        public string author {get;set;}
        public List<Record> apps {get;set;}
    }
    public class sessionWrapper
    {
        public string author {get;set;}
        public List<Record> sessions {get;set;}
    }
    public blogswrapper bWrapper {get;set;}
    public appsWrapper appWrapper {get;set;}
    public sessionWrapper sWrapper {get;set;}

    public  Object sendAsyncCallOutRequest()
    {
        // req1,req2,req3
        HttpRequest req1 = new HttpRequest();
        req1.setMethod('GET');
        req1.setEndpoint('https://sfdcstop.herokuapp.com/blogs');

        HttpRequest req2 = new HttpRequest();
        req2.setMethod('GET');
        req2.setEndpoint('https://sfdcstop.herokuapp.com/apps');

        HttpRequest req3 = new HttpRequest();
        req3.setMethod('GET');
        req3.setEndpoint('https://sfdcstop.herokuapp.com/sessions');

       //  service = new HTTPCalloutAsyncService(40, new List<HttpRequest>{req1,req2,req3});
       service = new HTTPCalloutAsyncService(40, new List<string>{'SFDCStopBlogs','SFDCStopApps','SFDCStopsessions'});
        system.debug('service: ' + service);
        Continuation con =  service.sendRequest('getAsyncCalloutResponse'); 
        // Continuation:[ContinuationMethod: getAsyncCalloutResponse, Timeout: 40]
        system.debug('continution: ' + con);
        requestLabels = service.getRequestLabels();
        system.debug('requestLabels: ' + requestLabels);
       // equestLabels: (Continuation-1, Continuation-2, Continuation-3)
        return con;


    }

    public  void getAsyncCalloutResponse()
    {
       List<HTTPResponse> responses = service.getResponse(requestLabels);
       system.debug('responses: ' + responses);
       
       bWrapper = (blogswrapper)JSON.deserialize(responses[0].getBody(), blogswrapper.class);
       appWrapper = (appsWrapper)JSON.deserialize(responses[1].getBody(), appsWrapper.class);
       sWrapper = (sessionWrapper)JSON.deserialize(responses[2].getBody(), sessionWrapper.class);


    }
}