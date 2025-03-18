@restResource(urlMapping='/AccountContactAPI/*')
global with sharing class AccountContactAPI 
{

    // @httpPost
    // global static AccountResponseWrapper createAccountContact()
    // {
    //     System.debug('createAccountContact called');
    //     AccountResponseWrapper responseObj = new AccountResponseWrapper(); // AccountResponseWrapper: [message=null,isSuccess=null]
    //     RestRequest req = RestContext.request;
    //     RestResponse resp = RestContext.response;
    //     System.debug('restRequest: ' + req);
    //     System.debug('restResponse: ' + resp);
    //     string jsonaccountString = req.requestBody.toString();
    //     System.debug('JSON Request body: ' + jsonaccountString); // { "customerName": "raja","isAccount": true }
    //     AccountContactWrapper accountObj;
    //     if(jsonaccountString != null && !String.isEmpty(jsonaccountString))
    //     {
    //          accountObj = (AccountContactWrapper)JSON.deserialize(jsonaccountString, AccountContactWrapper.class);
    //          System.debug('entered inside if block');
    //     } 
       
    //     System.debug('Wrapper accountObj: ' + accountObj); // AccountContactWrapper: [customerName=raja,isAccount=true,annualRevenue=5000]
    //     if(accountObj != null && accountObj.isAccount == true)
    //     {
    //         System.debug('Account creation call');
    //          Account acc = new Account();
    //          acc.name = accountObj.customerName;
    //          acc.annualRevenue = accountObj.annualRevenue;
    //          insert acc;
    //          System.debug('acc obj: ' + acc);
    //          responseObj.message= 'Account record successfully created with id: ' + acc.Id;
    //          responseObj.isSuccess = true;
    //          System.debug('responseObjAccount: ' + responseObj);
    //          return responseObj;

    //     }
    //     else if(accountObj != null && accountObj.isAccount == false)
    //     {
    //         System.debug('Contact creation call');
    //         Contact contObj = new Contact();
    //         contObj.LastName = accountObj.customerName;
    //         insert contObj;
    //         System.debug('contObj: ' + contObj);
    //         responseObj.message= 'contact record successfully created with id: ' + contObj.Id;
    //          responseObj.isSuccess = true;
    //          System.debug('responseObjcontact: ' + responseObj);
    //          return responseObj;
    //     }
    //     else 
    //     {
    //         responseObj.isSuccess = false;
    //         responseObj.message = 'Account/contact creation failed, json body madatory field';
    //         System.debug('responseObj failed: ' + responseObj);
    //         return responseObj;
    //     }


    // }

       @httpDelete
       global static AccountResponseWrapper deleteAccountBasedOnId()
       {
        AccountResponseWrapper respObj = new AccountResponseWrapper();
           RestRequest req = RestContext.Request;
           System.debug('req: ' + req);
          string rquestUri = req.requestURI; // /AccountContactAPI/001J100000BqhzdIAB
          integer indexposition = rquestUri.lastIndexOf('/');
          string accountId = rquestUri.substring(indexPosition+1);
          System.debug('accountId: ' + accountId);
          Account acc = new Account();
          if(!String.isEmpty(accountId))
          {
            try {
                acc.Id = accountId;
                delete acc;
                respObj.message = 'Account deleted successfully';
                respObj.isSuccess = true;
                
            } catch (Exception ex) 
            {
                respObj.message = ex.getMessage();
                respObj.isSuccess = false;
                
                
            }
           

          }
          else {
                   respObj.message = 'please pass the accountId as queryparameter';
                  respObj.isSuccess = false;
          }
          return respObj;
         

       }

      @httpPut
     global static AccountResponseWrapper updateAccountName()
     {
        System.debug('updateAccountName called');
        AccountResponseWrapper responseObj = new AccountResponseWrapper();
        RestRequest req = RestContext.request;
        Map<String,String> paramsMap = req.params;
        System.debug('paramsMap: ' + paramsMap); // {AccountName=updateAccountName,Id=001J100000BqhzdIAB}
       string accountName = paramsMap.get('AccountName'); // updateAccountName
       string  accountId = paramsMap.get('Id'); // 001J100000BqhzdIAB
       System.debug('accountName: ' + accountName);
       System.debug('accountId: ' + accountId);
         if(String.isEmpty(accountName))
         {
            responseObj.message = 'accountName required query parameter. please pass it';
            responseObj.isSuccess = false;
            return responseObj;

         }
         else if(String.isEmpty(accountId))
         {
            responseObj.message = 'accountId required query parameter. please pass it';
            responseObj.isSuccess = false;
            return responseObj;


         }
         Account updateAccountObj;
      
        try {
            updateAccountObj = [select Id,Name,Rating,Phone from Account where Id=:accountId WITH SECURITY_ENFORCED];
            System.debug('updateAccountObj1: ' + updateAccountObj);
            updateAccountObj.Name = accountName;
            update updateAccountObj;
            
        } catch (Exception ex) 
        {
                    responseObj.message = ex.getMessage();
                    responseObj.isSuccess = false;
                    return responseObj;
            
        }
      

       System.debug('updateAccountObj: ' + updateAccountObj);
       responseObj.message = 'Account successfully updated with id: ' + updateAccountObj.Id;
       responseObj.isSuccess = true;
       return responseObj;
     

       
     }

     
        @httpPost   
       global static AccountResponseWrapper createAccount()
       {
        System.debug('createAccount called');
        AccountResponseWrapper responseObj = new AccountResponseWrapper();
        RestRequest req = RestContext.request;
        System.debug('req: ' + req);
        Map<String,String> params = req.params;
        System.debug('params: ' + params); // {AnnualRevenue=90000, Name=rajapost, Rating=Hot}
        integer annualRevenue;
        String annual = params.get('AnnualRevenue');
        System.debug('annual: ' + annual);
        System.debug('isEmpty: ' + String.isEmpty(annual));
        if(params.containskey('AnnualRevenue') && !String.isEmpty(params.get('AnnualRevenue')))
        {
            annualRevenue = integer.valueOf(params.get('AnnualRevenue')); // 90000
        }
        
        string name = params.get('Name'); // rajapost
        string rating = params.get('Rating'); // Hot
        System.debug('annualRevenue: ' + annualRevenue);
        System.debug('name: ' + name); // rajapost
        System.debug('rating: ' + rating);

         System.debug('name: ' + name);
         Account acc = new Account();
         try {
            
            acc.Name = name;
            acc.Rating = rating;
            acc.AnnualRevenue = annualRevenue;
            insert acc;
            
         } catch (Exception ex) {
             System.debug('exeception occured: ' + ex);
             responseObj.message =  ex.getMessage();
             responseObj.isSuccess = false;
             return responseObj;

         }
        
         System.debug('AccountObj: ' + acc);
         responseObj.message = 'account created successfully with id: ' + acc.Id;
         responseObj.isSuccess = true;
         System.debug('responseObj: ' + responseObj);
         return responseObj;


       }

    

    @httpGet
    global static ResponseWrapper getAccount()
    {
        System.debug('getAccount called');
        RestRequest req = RestContext.request;
        // RestResponse resp = RestContext.response;
        // System.debug('resp: ' + resp);
        ResponseWrapper respObj = new ResponseWrapper(); // ResponseWrapper:[statusCode= null,responseBody=null]
        System.debug('respObj: ' + respObj);

       
        System.debug('request: ' + req);
        String requestURI = req.requestURI; // requestURI=/AccountContactAPI/123
        integer lastIndexPosition = requestURI.lastIndexOf('/'); // 18
        System.debug('lastIndexPosition: ' + lastIndexPosition);
     
        String accountNumber = requestURI.substring(lastIndexPosition + 1);
        System.debug('accountNumber: ' + accountNumber); // 123
        Account actObj;

        try {
            actObj = [select id,name,type,AccountNumber,industry from account WITH_SECURITY_ENFORCED where AccountNumber=:accountNumber];
            System.debug('myAccount Obj: ' + actObj);
         
            
        } catch (Exception ex) 
        {
            System.debug('Exception: ' + ex);
            respObj.statusCode = 500;
            respObj.responseBody = String.valueOf('Error code: ' + ex);
            System.debug('resp: ' + respObj);
            return respObj;
           
            
        }
       System.debug('Account Obj: ' + actObj);
       respObj.statusCode = 200; // success
       respObj.responseBody = String.valueOf('Account Name: ' + actObj.name + ', Account Id: ' + actObj.id);
       System.debug('returned response Body: ' + respObj);
        return respObj;

       
    }


    // @httpGet
    // global static void getAccounts()
    // {
    //     RestRequest request = RestContext.Request;
    //     RestResponse responseObj = RestContext.Response;
    //     System.debug('responseObj: ' + responseObj);
    //     System.debug('request: ' + request);
    //     string requestURI = request.requestURI;
    //     System.debug('requestURI: ' + requestURI);

    //     List<Account> actsList = [select Id,Name,Phone,Rating from Account WITH_SECURITY_ENFORCED limit 1 ];
    //     responseObj.addHeader('content-type','application-json');
    //     string jsonString = '{"message":"succseefully retrived","status":200}';
    //     responseObj.responseBody = Blob.valueOf(jsonString);
    //     responseObj.statusCode = 300;
    //     System.debug('responseObj12: ' + responseObj);
    //    // return actsList;

    // }

    
}