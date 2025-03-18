public with sharing class BlogsContinutionLightningController 
{
    public BlogsContinutionLightningController() {

    }
    public class Record
    {
        public string id;
        public string title;
        public string url;

    }

    public class BlogsWrapper
    {
        public string author {get;set;}
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
   
    @AuraEnabled(cacheable = true Continuation = true)
    public static Object fetchData()
    {
        system.debug('inside fetchData method');
        HTTPCalloutAsyncService service = new HTTPCalloutAsyncService(40, new List<String> {'SFDCStopBlogs','SFDCStopApps','SFDCStopsessions'});
        return service.sendRequest('sendResponse');

    }

     @AuraEnabled(Cacheable = true)
    public static Object sendResponse(List<String> labels, Object state)
    {
        System.debug('inside sendResponse Method');
      HTTPCalloutAsyncService service = new HTTPCalloutAsyncService(40, new List<string> {'SFDCStopBlogs','SFDCStopApps','SFDCStopsessions'});
      List<HTTPResponse> responses = service.getResponse(labels);
         BlogsWrapper bWrapper =  (BlogsWrapper)JSON.deserialize(responses.get(0).getBody(), BlogsWrapper.class);
         AppsWrapper  aWrapper = (AppsWrapper)JSON.deserialize(responses.get(1).getBody(), AppsWrapper.class);
         SessionWrapper sWrapper = (SessionWrapper)JSON.deserialize(responses.get(2).getBody(), SessionWrapper.class);

         ResponseWrapper wrapper = new ResponseWrapper();
         wrapper.blogData = bWrapper;
         wrapper.appData = aWrapper;
         wrapper.sessionData = sWrapper;
         system.debug('wrapper: ' + wrapper);

         return JSON.serialize(wrapper);

    }

}