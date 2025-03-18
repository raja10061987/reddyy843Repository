@isTest
public with sharing class AccountContactAPITest 
{

    @TestSetup
    static void makeData(){
        Account actObj = new Account();
        actObj.Name= 'suman';
        actObj.Phone = '8888909';
        actObj.Rating = 'Hot';
        actObj.accountNumber = '1234';
        actObj.AnnualRevenue = 9000;
        insert actObj;
        System.debug('actObj: ' + actObj);
        
    }


    @isTest
    public static void deleteAccountBasedOnIdTest1()
    {
        Id accountId = [select Id,Name from Account where Name='suman'].Id;
        System.debug('accountId: ' + accountId);
        RestRequest req = new RestRequest();
          req.requestURI = '/AccountContactAPI/' + accountId;
         req .httpMethod = 'Delete';
          RestContext.Request = req;
          AccountResponseWrapper returnedResponse;
          Test.startTest();
         returnedResponse = AccountContactAPI.deleteAccountBasedOnId();
          Test.stopTest();
           system.debug('returnedResponse : ' + returnedResponse );
             system.assertEquals(returnedResponse.isSuccess, true,'success should be true');

    }
    @isTest
    public static void deleteAccountBasedOnIdTest2()
    {
       
        RestRequest req = new RestRequest();
          req.requestURI = '/AccountContactAPI/001J100000BqjRgIAJ';
         req .httpMethod = 'Delete';
          RestContext.Request = req;
          AccountResponseWrapper returnedResponse;
          Test.startTest();
         returnedResponse = AccountContactAPI.deleteAccountBasedOnId();
          Test.stopTest();
           system.debug('returnedResponse : ' + returnedResponse );
             system.assertEquals(returnedResponse.isSuccess, false,'success should be false');

    }

    @isTest
    public static void deleteAccountBasedOnIdTest3()
    {
       
        RestRequest req = new RestRequest();
          req.requestURI = '/AccountContactAPI/';
         req .httpMethod = 'Delete';
          RestContext.Request = req;
          AccountResponseWrapper returnedResponse;
          Test.startTest();
         returnedResponse = AccountContactAPI.deleteAccountBasedOnId();
          Test.stopTest();
           system.debug('returnedResponse : ' + returnedResponse );
             system.assertEquals(returnedResponse.isSuccess, false,'success should be false');

    }

    @isTest
    public static void getAccountTest()
    {
        RestRequest request = new RestRequest(); // RestRequest[requestURI=,params=,httpMethod=]
        request.requestURI = '/AccountContactAPI/1234';
        request.httpMethod = 'GET';
        restContext.request = request;
        ResponseWrapper returnedResponse = AccountContactAPI.getAccount();
        System.debug('returnedResponse: ' + returnedResponse);
        system.assertEquals(returnedResponse.statusCode,200,'response code should be 200');
    }

    @isTest
    public static void updateAccountNameTest1()
    {
        Account actObj = [select Id,Name,Phone,Rating from Account where Name='suman'];
        System.debug('test method actObj: ' + actObj);
        RestRequest reqObj = new RestRequest();
         reqObj.addparameter('AccountName', 'workbenchupdate');
         reqObj.addparameter('Id', actObj.Id);
          reqObj.httpMethod = 'PUT';
           system.debug('reqObj: ' + reqObj);
           RestContext.request = reqObj;
           AccountResponseWrapper returnedResponse;
           Test.startTest();
            returnedResponse = AccountContactAPI.updateAccountName();
           Test.stopTest();
               system.debug('returnedResponse: ' + returnedResponse );
            system.assertEquals(returnedResponse.isSuccess, true, 'success should be true');
    }

    @isTest
    public static void updateAccountNameTest2()
    {
        Account actObj = [select Id,Name,Phone,Rating from Account where Name='suman'];
        System.debug('test method actObj: ' + actObj);
        RestRequest reqObj = new RestRequest();
        // reqObj.addparameter('AccountName', 'workbenchupdate');
         reqObj.addparameter('Id', actObj.Id);
          reqObj.httpMethod = 'PUT';
           system.debug('reqObj: ' + reqObj);
           RestContext.request = reqObj;
           AccountResponseWrapper returnedResponse;
           Test.startTest();
            returnedResponse = AccountContactAPI.updateAccountName();
           Test.stopTest();
               system.debug('returnedResponse: ' + returnedResponse );
            system.assertEquals(returnedResponse.isSuccess, false, 'success should be false');
    }

    @isTest
    public static void updateAccountNameTest3()
    {
        RestRequest reqObj = new RestRequest();
        reqObj.addparameter('AccountName', 'updateAccount');
        reqObj.httpMethod = 'PUT';
        RestContext.request = reqObj;
        AccountResponseWrapper returnedResponse;
        Test.startTest();
        returnedResponse = AccountContactAPI.updateAccountName();
        Test.stopTest();
        System.debug('returnedResponse: ' + returnedResponse);
        system.assert(returnedResponse.isSuccess == false,'success should be false');
        system.assertEquals(returnedResponse.isSuccess,false, 'success should be false');
    }
    @isTest
    public static void updateAccountNameTest4()
    {
        // Account actObj = [select Id,Name,Phone,Rating from Account where Name='suman12'];
        // System.debug('test method actObj: ' + actObj);
        RestRequest reqObj = new RestRequest();
         reqObj.addparameter('AccountName', 'workbenchupdate');
         reqObj.addparameter('Id', '001J100000BqhzdIABCD');
          reqObj.httpMethod = 'PUT';
           system.debug('reqObj: ' + reqObj);
           RestContext.request = reqObj;
           AccountResponseWrapper returnedResponse;
           Test.startTest();
            returnedResponse = AccountContactAPI.updateAccountName();
           Test.stopTest();
               system.debug('returnedResponse: ' + returnedResponse );
            system.assertEquals(returnedResponse.isSuccess, false, 'success should be false');
    }



    @isTest
    public static void getAccountTest1()
    {
        RestRequest request = new RestRequest(); // RestRequest[requestURI=,params=,httpMethod=]
        request.requestURI = '/AccountContactAPI/123489';
        request.httpMethod = 'GET';
        restContext.request = request;
        ResponseWrapper returnedResponse = AccountContactAPI.getAccount();
        System.debug('returnedResponse: ' + returnedResponse);
        system.assertEquals(returnedResponse.statusCode,500,'response code should be 500');
    }


    // @isTest
    // public static void createAccountContactTest1()
    // {
    //     RestRequest req = new RestRequest();
    //     System.debug('createAccountContactTest1 called');
    //     // req.requestURI = '/services/apexrest/AccountContactAPI/';
    //     String jsonBodyString = '{"customerName":"accounttpostworkbench","annualRevenue":90000,"isAccount":true}';
    //     req.requestBody= blob.valueOf(jsonBodyString);
    //    //  req.httpMethod = 'POST';
    //     RestContext.request = req;
    //    system.debug('RestContext.request: ' + RestContext.request);
    //      Test.startTest();
    //   AccountResponseWrapper returnedResponse = AccountContactAPI.createAccountContact();
    //   Test.stopTest();
      
    //   system.debug('returnedResponse ' + returnedResponse);
    //    system.assert(returnedResponse.isSuccess, true);
       

    // }

    
    // @isTest
    // public static void createAccountContactTest2()
    // {
    //     RestRequest req = new RestRequest();
    //     String jsonBodyString = '{"customerName":"accounttpostworkbench","annualRevenue":90000,"isAccount":false}';
    //     req.requestBody= blob.valueOf(jsonBodyString);
    //     req.httpMethod = 'POST';
    //     RestContext.request = req;
    //      Test.startTest();
    //   AccountResponseWrapper returnedResponse = AccountContactAPI.createAccountContact();
    //   Test.stopTest();
    //    system.assert(returnedResponse.isSuccess, true);
       

    // }

    // @isTest
    // public static void createAccountContactTest3()
    // {
    //     RestRequest req = new RestRequest();
    //     String jsonBodyString = '{"customerName":"accounttpostworkbench","annualRevenue":90000}';
    //     req.requestBody= blob.valueOf(jsonBodyString);
    //     req.httpMethod = 'POST';
    //     RestContext.request = req;
    //     AccountResponseWrapper returnedResponse;
    //      Test.startTest();
    //       returnedResponse = AccountContactAPI.createAccountContact();
    //   Test.stopTest();
    //   System.debug('returnedResponse: ' + returnedResponse);
    //  //  system.assert(returnedResponse.isSuccess, false);
    //    system.assertEquals(returnedResponse != null, true, 'returnedResponse should not empty');
       

    // }

    @isTest
    public static void createAccountTest()
    {
        RestRequest req = new RestRequest();
        req.addParameter('Name','workbenchName');
        req.addParameter('Rating','Hot');
        req.addParameter('AnnualRevenue','80001');
         req.httpMethod = 'POST';
         system.debug('reqObj12: ' + req);
          RestContext.request = req;
         System.debug('RestContext.request: ' + RestContext.request);
         AccountResponseWrapper returnedResponse;
         Test.startTest();
           returnedResponse = AccountContactAPI.createAccount();
          Test.stopTest();
            System.debug('returnedResponse: ' + returnedResponse);
           // system.assertEquals(returnedResponse.isSuccess, false, 'response should be fail');
          system.assertEquals(returnedResponse.isSuccess, true, 'response should be successfull');

    }

    @isTest
    public static void createAccountTest1()
    {
        RestRequest req = new RestRequest();
        req.addParameter('Name','workbenchName');
        req.addParameter('Rating','Hot');
     //   req.addParameter('AnnualRevenue','80001');
         req.httpMethod = 'POST';
         system.debug('reqObj12: ' + req);
          RestContext.request = req;
         System.debug('RestContext.request: ' + RestContext.request);
         AccountResponseWrapper returnedResponse;
         Test.startTest();
           returnedResponse = AccountContactAPI.createAccount();
          Test.stopTest();
            System.debug('returnedResponse: ' + returnedResponse);
           system.assertEquals(returnedResponse.isSuccess, false, 'response should be fail');
          // system.assertEquals(returnedResponse.isSuccess, true, 'response should be successfull');
    }

   
}