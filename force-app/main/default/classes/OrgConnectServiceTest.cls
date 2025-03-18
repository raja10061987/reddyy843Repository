@isTest
public class OrgConnectServiceTest 
{
    public static final string ACCOUNT_RESPONSE_BODY = '{"id":"0012w00000z357TAAQ","success":true,"errors":[]}';
    public static final string CONTACT_RESPONSE_BODY = '{"id":"0032w00000lsqMdAAI","success":true,"errors":[]}';
    public static final string CONTACT_QUERY_RESPONSE_BODY = '{"totalSize":1,"done":true,"records":[{"attributes":{"type":"Contact","url":"/services/data/v53.0/sobjects/Contact/0032w00000lsqMdAAI"},"Name":"suman test-11","Phone":null,"Email":null,"Account":{"attributes":{"type":"Account","url":"/services/data/v53.0/sobjects/Account/0012w00000z357TAAQ"},"Name":"account service-test11"}}]}';
    public static final integer CREATE_RESPONSE_CODE = 201;
    public static final integer CONTACT_QUERY_RESPONSE_CODE = 200;
    
    
    
    public static testMethod void createAccountAndContactTest()
    {
       test.startTest();
        HTTPCalloutServiceMock accountMock = new HTTPCalloutServiceMock(CREATE_RESPONSE_CODE,ACCOUNT_RESPONSE_BODY);
        HTTPCalloutServiceMock contactMock = new HTTPCalloutServiceMock(CREATE_RESPONSE_CODE,CONTACT_RESPONSE_BODY);
        HTTPCalloutServiceMock ContactQueryMock = new HTTPCalloutServiceMock(CONTACT_QUERY_RESPONSE_CODE,CONTACT_QUERY_RESPONSE_BODY);
        
        
        HTTPCalloutServiceMultiMock multiMockObj = new HTTPCalloutServiceMultiMock();
        HTTPCalloutService destinationService = new HTTPCalloutService('myLogion000ORG');
        // baseurl: https://login000-dev-ed.my.salesforce.com/services/data/v53.0        
        multiMockObj.addCalloutMock(destinationService.getEndpointURL() + '/sobjects/Account', accountMock);
        multiMockObj.addCalloutMock(destinationService.getEndpointURL() + '/sobjects/Contact', contactMock);
        multiMockObj.addCalloutMock(destinationService.getEndpointURL() + '/query?q=select+name,phone,email,account.Name+from+Contact+where+id=\'0032w00000lsqMdAAI\'', ContactQueryMock);
        
        test.setMock(HTTPCalloutMock.class, multiMockObj);
        
        Contact conObj = new Contact();
        conObj.FirstName = 'suman';
        conObj.LastName = 'test-11';
        map<string,string> returnedresponse = OrgConnectService.createAccountAndContact('account service-test11',conObj);
        system.debug('returnedresponse: ' + returnedresponse);
        // {message=all requests are successfull, success=1}
        System.assertEquals(OrgConnectService.SUCCESS_CODE, returnedresponse.get('success'), 'success code should be: ' +OrgConnectService.SUCCESS_CODE);
        System.assertEquals(OrgConnectService.SUCCESS_MESSAGE, returnedresponse.get('message'), 'message should be: ' + OrgConnectService.SUCCESS_MESSAGE);
       test.stopTest();
    }
    
    @isTest
    public static void testWrongResponseAccount()
    {
        HTTPCalloutServiceMock acctMock = new HTTPCalloutServiceMock(CONTACT_QUERY_RESPONSE_CODE,ACCOUNT_RESPONSE_BODY);
        
        Test.setMock(HttpCalloutMock.class, acctMock);
        Contact conObj = new Contact();
        conObj.FirstName = 'suman';
        conObj.LastName = 'test-11';
        map<string,string> returnedresponse = OrgConnectService.createAccountAndContact('account service-test11',conObj); 
        system.debug('returnedresponse: ' + returnedresponse);
        // {message=cannot able to create account, success=0}
        System.assertEquals(OrgConnectService.ERROR_CODE, returnedresponse.get('success'), 'error code should be: ' + OrgConnectService.ERROR_CODE);
        System.assertEquals(OrgConnectService.ACCOUNT_ERROR_MESSAGE, returnedresponse.get('message'),'message should be: ' + OrgConnectService.SUCCESS_MESSAGE);
        
    }
    
    
    public static testMethod void testWronResponseContact()
    {
        test.startTest();
        HttpCalloutServiceMock actMock = new HttpCalloutServiceMock(CREATE_RESPONSE_CODE,ACCOUNT_RESPONSE_BODY);
        HttpCalloutServiceMock contMock = new HttpCalloutServiceMock(CONTACT_QUERY_RESPONSE_CODE,CONTACT_RESPONSE_BODY);
        
        HTTPCalloutServiceMultiMock multMock = new HTTPCalloutServiceMultiMock();
        HTTPCalloutService destinationService = new HTTPCalloutService('myLogion000ORG');
        
        multMock.addCalloutMock(destinationService.getEndpointURL() + '/sobjects/Account', actMock);
        multMock.addCalloutMock(destinationService.getEndpointURL() + '/sobjects/Contact', contMock);
        
        Test.setMock(HttpCalloutMock.class, multMock);
        
        Contact conObj = new Contact();
        conObj.FirstName = 'suman';
        conObj.LastName = 'test-11';
        map<string,string> returnedresponse = OrgConnectService.createAccountAndContact('account service-test11',conObj);
        system.debug('returnedResponse: ' + returnedResponse);
        // {message=cannot able to create Contact, success=0}
        System.assertEquals(OrgConnectService.CONTACT_ERROR_MESSAGE, returnedResponse.get('message'), 'message should be: ' + OrgConnectService.CONTACT_ERROR_MESSAGE);
        System.assertEquals(OrgConnectService.ERROR_CODE,returnedResponse.get('success'),'code should be: ' + OrgConnectService.ERROR_CODE);
        test.stopTest();
    }
    
    public static testMethod void testWrongResponseContactQuery()
    {
        test.startTest();
        HttpCalloutServiceMock actMock = new HttpCalloutServiceMock(CREATE_RESPONSE_CODE,ACCOUNT_RESPONSE_BODY);
        HttpCalloutServiceMock contMock = new HttpCalloutServiceMock(CREATE_RESPONSE_CODE,CONTACT_RESPONSE_BODY);
        HttpCalloutServiceMock contQueryMock = new HttpCalloutServiceMock(CREATE_RESPONSE_CODE,CONTACT_QUERY_RESPONSE_BODY);
        HTTPCalloutServiceMultiMock multiMock = new HTTPCalloutServiceMultiMock();
        HttpCalloutService destinationOrgService = new HttpCalloutService('myLogion000ORG');
            
        multiMock.addCalloutMock(destinationOrgService.getEndpointURL() + '/sobjects/Account', actMock);
        multiMock.addCalloutMock(destinationOrgService.getEndpointURL() + '/sobjects/Contact', contMock);
        multiMock.addCalloutMock(destinationOrgService.getEndpointURL() + '/query?q=select+name,phone,email,account.Name+from+Contact+where+id=\'0032w00000lsqMdAAI\'', contQueryMock);
        
        Test.setMock(HttpCalloutMock.class, multiMock);
        Contact conObj = new Contact(FirstName='suman',LastName='test-11');
        map<string,string> returnedResponse = OrgConnectService.createAccountAndContact('account service-test11', conObj);
        system.debug('returnedResponse: ' + returnedResponse);
        //  {message=cannot able to retrive Contact, success=0}
        System.assertEquals(OrgConnectService.ERROR_CODE,returnedResponse.get('success'),'Status code should be: ' +  OrgConnectService.ERROR_CODE);
        System.assertEquals(OrgConnectService.CONTACT_QUERY_MESSAGE, returnedResponse.get('message'), 'message should be: ' +OrgConnectService.CONTACT_QUERY_MESSAGE);
        test.stopTest();
        
        
    }

}