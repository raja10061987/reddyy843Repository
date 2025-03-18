public with sharing class mySFDCcallOut 
{
 public static httpResponse getBlogs()
 {
     Http http = new Http();
     httpRequest request = new HttpRequest();
     request.setEndpoint('https://sfdcstop.herokuapp.com/blogs');
     request.setMethod('GET');
     httpResponse response = http.send(request);
     if(response.getStatusCode() == 200)
     {
        SfdcStopWrapper wrapperResponse =  SfdcStopWrapper.parse(response.getBody());
        system.debug('author: ' + wrapperResponse.author);
      if(wrapperResponse.blogs != null && !wrapperResponse.blogs.isEmpty())
      {
       for (Integer i = 0; i < wrapperResponse.blogs.size(); i++)
       {
        SfdcStopWrapper.Blogs blogObj =  wrapperResponse.blogs.get(i);
        system.debug('===========================');
       //  system.debug('each blog Obj: ' + blogObj);
       system.debug('Id: ' + blogObj.id);
       system.debug('title: ' + blogObj.title);
       system.debug('url: ' + blogObj.url);

        
       }
      }
     }
     return response;

 }
   
}