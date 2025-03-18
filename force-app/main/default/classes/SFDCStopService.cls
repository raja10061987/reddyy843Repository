public with sharing class SFDCStopService 
{
    public static httpResponse getSFDCBlogs()
    {
        HTTPCalloutService service = new HTTPCalloutService('SFDCStopBlogs');
       httpResponse blogAPIResponse =  service.sendRequest();
       // system.debug('response: ' + blogAPIResponse);
        return blogAPIResponse;
    }

}