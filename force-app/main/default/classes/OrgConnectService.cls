public with sharing class OrgConnectService 
{
    public static final string ERROR_CODE = '0';
    public static final string SUCCESS_CODE = '1';
    public static final string ACCOUNT_ERROR_MESSAGE = 'cannot able to create account';
    public static final string CONTACT_ERROR_MESSAGE = 'cannot able to create Contact';
    public static final string CONTACT_QUERY_MESSAGE = 'cannot able to retrive Contact';
    public static final string SUCCESS_MESSAGE = 'all requests are successfull';
    
    
   public static map<string,string> createAccountAndContact(string acctName,Contact conObj)
   {
       id accountId = null;
       map<string,string> responseMap = new map<string,string>();
       // step1: create account
       
       HTTPCalloutService destinationService = new HTTPCalloutService('myLogion000ORG');
       // http://callout:Login000API/services/data/v53.0
       destinationService.setEndpointURL(destinationService.getEndpointURL() + '/sobjects/Account');
       // callout:Login000API/services/data/v53.0/sobjects/Account
       //  {"attributes":{"type":"Account"},"Name":"account service24","Rating":"Cold","Phone":"7013948962"}
       Account actObj = new Account();
       actObj.Name = acctName;
       actObj.Rating = 'Cold';
       actObj.Phone = '7013948962';
       destinationService.setRequestBody(JSON.serialize(actObj));
       system.debug('accont EndPoint: ' + destinationService.getEndpointURL());
       system.debug('account RequetsBody: ' + destinationService.getRequestBody());
       // make call out
       httpResponse accountCreateResponse = destinationService.sendRequest();
      system.debug('accountCreateResponse code: ' + accountCreateResponse.getStatusCode()); // 201
         system.debug('accountResponseBody: ' + accountCreateResponse.getBody());
       if(accountCreateResponse.getStatusCode() == 201)
       { // success
         map<string,Object> accountResponseBody = (map<string,Object>)JSON.deserializeUntyped(accountCreateResponse.getBody());
  
           // {errors=[],id=ascjnasjn,success=true}
           if(boolean.valueOf(accountResponseBody.get('success')))
           {
               accountId = id.valueOf(String.valueOf(accountResponseBody.get('id')));
               system.debug('account is created with id: ' + accountId);
           }
       }
       else
       { // fail
          responseMap.put('success',ERROR_CODE); // 0
          responseMap.put('message',ACCOUNT_ERROR_MESSAGE);
           return responseMap;
       }
        
       
       // step2: create contact with related account
       // callout:Login000API/services/data/v53.0/sobjects/Account
       id contactId = null;
       string contactEndPoint = destinationService.getEndpointURL().substringBeforeLast('Account') + 'Contact';
       // callout:Login000API/services/data/v53.0/sobjects/Contact
       destinationService.setEndpointURL(contactEndPoint);
       conObj.AccountId = accountId;
       destinationService.setRequestBody(JSON.serialize(conObj));
       system.debug('contact EndPoint: ' + destinationService.getRequest());
       system.debug('contact request Body: ' + destinationService.getRequestBody());
       httpResponse contactCreateResponse = destinationService.sendRequest();
       system.debug('contactCreateResponse code: ' + contactCreateResponse.getStatusCode()); // 201
       system.debug('contactCreateResponse body: ' + contactCreateResponse.getBody());
       
       if(contactCreateResponse.getStatusCode() == 201)
       {
           // success
           map<string,Object> contactCreateResponseBody = (map<string,Object>)JSON.deserializeUntyped(contactCreateResponse.getBody());
           // {errors=[],id=ascjnasjn,success=true}
           if(boolean.valueOf(contactCreateResponseBody.get('success')))
           {
               contactId = id.valueOf(String.valueOf(contactCreateResponseBody.get('id')));
               system.debug('contact is created with id: ' + contactId);
           }
       }
       else
       { // error
          responseMap.put('success',ERROR_CODE); // 0
          responseMap.put('message',CONTACT_ERROR_MESSAGE);
          return responseMap;  
       }
       
       // step3:  query Contact with related account
       // [Endpoint=callout:Login000API/services/data/v53.0/sobjects/Contact, Method=POST]
       
      // callout:Login000API/services/data/v53.0/query/?q=select+name,Account.Name+from+Contact+where+id=kCNkSJNasn
      string queryContactEndPoint = destinationService.getEndpointURL().substringBeforeLast('sobjects/Contact') + 'query';
       //  callout:Login000API/services/data/v53.0/query
       destinationService.setEndpointURL(queryContactEndPoint);
        destinationService.setURLParameter('q', 'select+name,phone,email,account.Name+from+Contact+where+id=\''+contactId+'\'') ;
       //[Endpoint=callout:Login000API/services/data/v53.0/sobjects/Contact?q=select+name,phone,email,account.Name+from+Contact+where+id='0032w00000lOG8bAAG', Method=GET]
       destinationService.setRequestMethod('GET');
       destinationService.setRequestBody(null);
       destinationService.removeHeaderParameter('Content-Type');
       system.debug('contact query Requets: ' + destinationService.getRequest());
       httpResponse contactQueryResponse = destinationService.sendRequest();
       system.debug('contactQueryResponse code: ' + contactQueryResponse.getStatusCode()); // 200
       if(contactQueryResponse.getStatusCode() == 200) // 200
       {
           system.debug('contactQueryResponse getBody: ' + contactQueryResponse.getBody());
       }
       else
       {
           responsemap.put('success',ERROR_CODE); // 0
           responsemap.put('message',CONTACT_QUERY_MESSAGE);
           return responsemap;
       }
       
       
       
       
       
       responseMap.put('success',SUCCESS_CODE); // 1
        responseMap.put('message',SUCCESS_MESSAGE); // all requests are successfull
       return responseMap;
   }
}