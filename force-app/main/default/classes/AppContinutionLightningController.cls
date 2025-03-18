public with sharing class AppContinutionLightningController {
    public AppContinutionLightningController() {

    }
    public class Record
    {
        public string id;
        public string title;
        public string url;
    }

    public class BlogsWrapper
    {
        public string author;
        public List<Record> blogs;
    
    }
    public class AppsWrapper
    {
        public string author;
        public List<Record> apps;
    }
    public class SessionWrapper
    {
        public string author;
        public List<Record> sessions;
    }
    public class ResponseWrapper
    {
        public BlogsWrapper blogData;
        public AppsWrapper appData;
        public SessionWrapper sessionData;

    }

    @AuraEnabled(Cacheable = true Continuation = true)
    public static Object fetchData(){
        try {
             HttpRequest req1 = new HttpRequest();
             req1.setMethod('GET');
             req1.setEndpoint('https://sfdcstop.herokuapp.com/blogs');
             HttpRequest req2 = new HttpRequest();
             req2.setMethod('GET');
             req2.setEndpoint('https://sfdcstop.herokuapp.com/apps');

             HttpRequest req3 = new HttpRequest();
             req3.setEndpoint('GET');
             req3.setEndpoint('https://sfdcstop.herokuapp.com/sessions');

            //  HTTPCalloutAsyncService service = new HTTPCalloutAsyncService(40, new List<HttpRequest> {req1,req2,req3});
            HTTPCalloutAsyncService service = new HTTPCalloutAsyncService(40, new List<string> {'SFDCStopBlogs','SFDCStopApps','SFDCStopsessions'});
             return service.sendRequest('getResponse');
             
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(Cacheable = true)
    public static Object getResponse( List<String> labels, Object state)
    {
        try 
        {
            

            HTTPCalloutAsyncService service = new HTTPCalloutAsyncService(40, new List<string> {'SFDCStopBlogs','SFDCStopApps','SFDCStopsessions'});
        List<HTTPResponse> responses = service.getResponse(labels);
        BlogsWrapper bWrapper = (BlogsWrapper)JSON.deserialize(responses.get(0).getBody(), BlogsWrapper.class);
        AppsWrapper awrapper = (AppsWrapper)JSON.deserialize(responses.get(1).getBody(), AppsWrapper.class);
        SessionWrapper sWrapper = (SessionWrapper)JSOn.deserialize(responses.get(2).getBody(), SessionWrapper.class);

        
        ResponseWrapper wrapper = new ResponseWrapper();
        wrapper.blogData = bWrapper;
        wrapper.appData = aWrapper;
        wrapper.sessionData = swrapper;
       System.debug('wrapper: ' + wrapper);
        return JSON.serialize(wrapper);
            
        } catch (Exception e) 
        {
            System.debug('exception message: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

}