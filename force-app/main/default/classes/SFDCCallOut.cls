public class SFDCCallOut 
{
   public static void httpCallOut()
   {
       Http http = new Http();
       HttpRequest httpRequest = new HttpRequest();
       
       httpRequest.setEndpoint('https://sfdcstop.herokuapp.com/blogs');
       httpRequest.setMethod('GET');
       system.debug('httpRequest: ' + httpRequest);
         httpResponse  calloutResponse =  http.send(httpRequest);
       system.debug('calloutResponse: ' + calloutResponse);
       if(calloutResponse.getStatusCode() == 200)
       {
           system.debug('inside if block');
           
           String jsonString = calloutResponse.getBody();
           system.debug('jsonString: ' + jsonString);
         SfdcWrapper sfdcWrapperResponse =  SfdcWrapper.parse(jsonString);
           system.debug('sfdcWrapperResponse: ' + sfdcWrapperResponse);
           system.debug('author: ' + sfdcWrapperResponse.author);
           system.debug('my blogs: ' + sfdcWrapperResponse.blogs);
            system.debug('blogs length: ' + sfdcWrapperResponse.blogs.size());
           
           for(integer i = 0; i < sfdcWrapperResponse.blogs.size(); i++)
           {
                system.debug('Id: ' + sfdcWrapperResponse.blogs.get(i).id);
                system.debug('title: ' + sfdcWrapperResponse.blogs.get(i).title);
                system.debug('url:  ' + sfdcWrapperResponse.blogs.get(i).url);
               system.debug('========================================');
           }
           
           
           
       }
       
   }
}