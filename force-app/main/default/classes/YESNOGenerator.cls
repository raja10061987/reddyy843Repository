public with sharing class YESNOGenerator {


    @InvocableMethod(label='generate random image' description='it will generate random image')
    public static List<YesNo> getYesNo()
    {
        List<YesNo> returnedYesNo = New List<YesNo>{generateRandomGenerator()};
        system.debug('returnedYesNo: ' + returnedYesNo);
        return returnedYesNo;
    }
   
    
    public static YesNo generateRandomGenerator()
    {
        YesNo yN = new YesNo();
        try {
           
        HTTP http = new HTTP();
        httpRequest request = new httpRequest();
        request.setEndPoint('https://yesno.wtf/api');
        request.setMethod('GET');
        System.debug('request: ' + request); // System.httpRequest[setEndPoint=,Method=GET]
        HttpResponse response = http.send(request);
        System.debug('response: ' + response); // System.httpResponse[Status=OK,StatusCode=200]
        if(response.getStatusCode() == 200)
        {
              yN = (YesNo)JSON.deserialize(response.getBody(),YesNo.class);

        }
        } catch (Exception ex) 
        {
            system.debug('Exception occured: ' + ex.getMessage());
           
            
        }
        system.debug('returned YesNo: ' + yN);
        return yN;
        

    }
}