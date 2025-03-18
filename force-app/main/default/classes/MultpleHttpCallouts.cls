public with sharing class MultpleHttpCallouts 
{
    public static final string SUCCESS_CODE = '1';
    public static final string ERROR_CODE = '0';
    public static final string BLOG_RESPONSE_FAIL = 'cannot able to retrive blogs';
    public static final string SESSIONS_RESPONSE_FAIL = 'cannot able to retrive sessions';
    public static final string APPS_RESPONSE_FAIL = 'cannot able to retrive Apps';
    public static final string SUCCESS_MESSAGE = 'All requests Success';
   public static map<string,string> getBlogsAppsSessions()
   { 
       // getting blogs, callout 1
       map<string,string> responseMap = new map<string,string>();
       HTTPCalloutService service = new HTTPCalloutService('multipleHttpCallouts'); // https://sfdcstop.herokuapp.com/
       service.setEndpointURL(service.getEndpointURL() + 'blogs'); // https://sfdcstop.herokuapp.com/blogs
        system.debug('getrequest: ' + service.getRequest());// [Endpoint=https://sfdcstop.herokuapp.com/blogs, Method=GET]
       // making call out
       httpResponse blogsResponse = service.sendRequest();
       system.debug('blogsResponse status code: ' + blogsResponse.getStatusCode()); // 200
       if(blogsResponse.getStatusCode() == 200)
       { // success
         Object blogResponseBody = JSON.deserializeUntyped(blogsResponse.getBody());
           system.debug('blogResponseBody: ' + blogResponseBody);
       }
       else
       {
          responseMap.put('success',ERROR_CODE); // 0
          responseMap.put('message',BLOG_RESPONSE_FAIL); // cannot able to retrive blogs
           return responseMap;
       }
       // getting apps , callout -2
       // [Endpoint=https://sfdcstop.herokuapp.com/blogs, Method=GET]
       // https://sfdcstop.herokuapp.com/
         string appsEndPoint = service.getEndpointURL().substringBeforeLast('blogs') + 'apps';
         service.setEndpointURL(appsEndPoint);
       system.debug('apps request: ' + service.getRequest());
       // [Endpoint=https://sfdcstop.herokuapp.com/apps, Method=GET]
       httpResponse appsResponse = service.sendRequest();
       system.debug('appsResponse code: ' + appsResponse.getStatusCode()); // 200
        if(appsResponse.getStatusCode() == 200)
        { // success
           string appsResponseBody = appsResponse.getBody();
            system.debug('appsResponseBody: ' + appsResponseBody);
        }
       else
       {
          responseMap.put('success',ERROR_CODE); // 0
          responseMap.put('message',APPS_RESPONSE_FAIL); // cannot able to retrive apps
           return responseMap;  
       }
       
       // sessions callout -3 
       //  [Endpoint=https://sfdcstop.herokuapp.com/apps, Method=GET]
       //  https://sfdcstop.herokuapp.com/
       string sessionsEndPoint = service.getEndpointURL().substringBeforeLast('apps') + 'sessions';
       // https://sfdcstop.herokuapp.com/sessions
         service.setEndpointURL(sessionsEndPoint);
       system.debug('sessions request: ' + service.getRequest());
       // System.HttpRequest[Endpoint=https://sfdcstop.herokuapp.com/sessions, Method=GET]
       httpResponse sessionResponse = service.sendRequest();
       system.debug('sessionResponse status code: ' + sessionResponse.getStatusCode()); // 200
       if(sessionResponse.getStatusCode() == 200)
       {
          map<string,Object> sessionResponseBody =  (Map<string,Object>)JSON.deserializeUntyped(sessionResponse.getBody());
          system.debug('sessionResponseBody: ' + sessionResponseBody);
           
       }
       else
       {
           responseMap.put('success',ERROR_CODE); // 0
           responseMap.put('message',SESSIONS_RESPONSE_FAIL); // cannot able to retrive sessions
           return responseMap;
       }
       
            responseMap.put('success',SUCCESS_CODE); // 1
            responseMap.put('message',SUCCESS_MESSAGE); // All requests Success
           return responseMap;
       
   }
}