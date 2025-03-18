@isTest
public with sharing class MultpleHttpCalloutsTest 
{
    public static final string BLOGS_RESPONSE_BODY = '{"author":"Rahul Malhotra","blogs":[{"id":"1","title":"Salesforce Integration Tutorial Part 1 - Introduction and Setting up Workbench","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-1.html"},{"id":"2","title":"Salesforce Integration Tutorial Part 2 - Exploring GET Method","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-2.html"},{"id":"3","title":"Salesforce Integration Tutorial Part 3 - Exploring POST Method","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-3.html"},{"id":"4","title":"Salesforce Integration Tutorial Part 4 - Exploring DELETE Method","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-4.html"},{"id":"5","title":"Salesforce Integration Tutorial Part 5 - Exploring PUT Method","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-5.html"},{"id":"6","title":"Salesforce Integration Tutorial Part 6 - Exploring PATCH Method","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-6.html"},{"id":"7","title":"Salesforce Integration Tutorial Part 7 - Creating a test class for Apex Web Service","url":"https://www.sfdcstop.com/2019/11/salesforce-integration-tutorial-part-7.html"},{"id":"8","title":"Salesforce Integration Tutorial Part 8 - Apex REST Callouts","url":"https://www.sfdcstop.com/2019/12/salesforce-integration-tutorial-part-8.html"},{"id":"9","title":"Salesforce Integration Tutorial Part 9 - Test class for Apex REST Callout","url":"https://www.sfdcstop.com/2019/12/salesforce-integration-tutorial-part-9.html"}]}';
    public static final string APPS_RESPONSE_BODY = '{"author":"Rahul Malhotra","apps":[{"id":"1","title":"HTTP Callout Framework","url":"https://www.sfdcstop.com/2019/12/httpcalloutframework-light-weight.html"},{"id":"2","title":"SFDX Deploy Tool","url":"https://www.sfdcstop.com/2019/06/sfdx-deploy-tool.html"},{"id":"3","title":"sObject Convertor","url":"https://www.sfdcstop.com/2018/03/sobject-convertor-utility-application.html"}]}';
    public static final string SESSIONS_RESPONSE_BODY = '{"author":"Rahul Malhotra","sessions":[{"id":"1","title":"Salesforce UI API","url":"https://www.sfdcstop.com/2018/06/salesforceuiapi.html"},{"id":"2","title":"Lightning Testing Service","url":"https://www.sfdcstop.com/2018/05/lightningtestingservice.html"},{"id":"3","title":"Lightning Data Service","url":"https://www.sfdcstop.com/2017/12/develop-lightning-components-faster.html"}]}';
    public static final integer GET_RESPONSE_CODE = 200;
    public static final integer WRONG_RESPONSE_CODE = 201;
    public MultpleHttpCalloutsTest() {

    }
    public static testMethod void getBlogsAppsSessionsTest()
    {
       HTTPCalloutServiceMock blogsMock = new HTTPCalloutServiceMock(GET_RESPONSE_CODE,BLOGS_RESPONSE_BODY);
       HTTPCalloutServiceMock appsMock = new HTTPCalloutServiceMock(GET_RESPONSE_CODE,APPS_RESPONSE_BODY);
       HTTPCalloutServiceMock sessonsMock = new HTTPCalloutServiceMock(GET_RESPONSE_CODE,SESSIONS_RESPONSE_BODY);

       HTTPCalloutServiceMultiMock multiMock = new HTTPCalloutServiceMultiMock();

       HTTPCalloutService destinationService = new HTTPCalloutService('multipleHttpCallouts');
        // https://sfdcstop.herokuapp.com/
       multiMock.addCalloutMock(destinationService.getEndpointURL() + 'blogs', blogsMock);
       multiMock.addCalloutMock(destinationService.getEndpointURL() + 'apps', appsMock);
       multiMock.addCalloutMock(destinationService.getEndpointURL() + 'sessions', sessonsMock);

       Test.setMock(HTTPCalloutMock.class, multiMock);
       test.startTest();
      Map<string,string> returnedResponse = MultpleHttpCallouts.getBlogsAppsSessions();
      system.debug('returnedResponse: ' + returnedResponse);
      // { message= All requests Success,success=1}
      System.assertEquals(MultpleHttpCallouts.SUCCESS_CODE, returnedResponse.get('success'), 'success code should be: ' + MultpleHttpCallouts.SUCCESS_CODE);
      System.assertEquals(MultpleHttpCallouts.SUCCESS_MESSAGE, returnedResponse.get('message'), 'message should be: ' + MultpleHttpCallouts.SUCCESS_MESSAGE);
       test.stopTest();

    }

    @isTest
    public static void getBlogsWrongResponseTest()
    {
        HTTPCalloutServiceMock blogsMock = new HTTPCalloutServiceMock(WRONG_RESPONSE_CODE,BLOGS_RESPONSE_BODY);

        Test.setMock(HttpCalloutMock.class, blogsMock);

        test.startTest();
      Map<string,string> returnedResponse = MultpleHttpCallouts.getBlogsAppsSessions();
      System.debug('returnedResponse: ' + returnedResponse);
      // {message=cannot able to retrive blogs, success=0}
      System.assertEquals(MultpleHttpCallouts.ERROR_CODE, returnedResponse.get('success'), 'Error code should be: ' + MultpleHttpCallouts.ERROR_CODE);
      System.assertEquals(MultpleHttpCallouts.BLOG_RESPONSE_FAIL, returnedResponse.get('message'), 'Message should be: ' + MultpleHttpCallouts.BLOG_RESPONSE_FAIL);
        test.stopTest();
    }

    public static testMethod void getAppsWrongResponseTest()
    {
        HTTPCalloutServiceMock blogsMock = new HTTPCalloutServiceMock(GET_RESPONSE_CODE,BLOGS_RESPONSE_BODY);
        HTTPCalloutServiceMock appsMock = new HTTPCalloutServiceMock(WRONG_RESPONSE_CODE,APPS_RESPONSE_BODY);

        HTTPCalloutServiceMultiMock multiMock = new HTTPCalloutServiceMultiMock();

        HTTPCalloutService service = new HTTPCalloutService('multipleHttpCallouts');
        // base url: https://sfdcstop.herokuapp.com/

        multiMock.addCalloutMock(service.getEndpointURL() + 'blogs', blogsMock);
        multiMock.addCalloutMock(service.getEndpointURL() + 'apps', appsMock);
        Test.setMock(HttpCalloutMock.class, multiMock);

        test.startTest();
           Map<String,String> returnedResponse = MultpleHttpCallouts.getBlogsAppsSessions();
           system.debug('returnedResponse: ' + returnedResponse);
           // {message=cannot able to retrive Apps, success=0}
           System.assertEquals(MultpleHttpCallouts.ERROR_CODE, returnedResponse.get('success'), 'code should be: ' + MultpleHttpCallouts.ERROR_CODE);
           System.assertEquals(MultpleHttpCallouts.APPS_RESPONSE_FAIL, returnedResponse.get('message'), 'message should be: ' + MultpleHttpCallouts.APPS_RESPONSE_FAIL);
           test.stopTest();
    }

    public static testMethod void getSessionsWrongResponseTest()
    {
        HTTPCalloutServiceMock blogsMock = new HTTPCalloutServiceMock(GET_RESPONSE_CODE,BLOGS_RESPONSE_BODY);
        HTTPCalloutServiceMock appsMock = new HTTPCalloutServiceMock(GET_RESPONSE_CODE,APPS_RESPONSE_BODY);
        HTTPCalloutServiceMock sessionsMock = new HTTPCalloutServiceMock(WRONG_RESPONSE_CODE,SESSIONS_RESPONSE_BODY);

        HTTPCalloutServiceMultiMock multiMock = new HTTPCalloutServiceMultiMock();

        HTTPCalloutService service = new HTTPCalloutService('multipleHttpCallouts');
        // endPointURL: https://sfdcstop.herokuapp.com/
        multiMock.addCalloutMock(service.getEndpointURL() + 'blogs', blogsMock);
        multiMock.addCalloutMock(service.getEndpointURL() + 'apps', appsMock);
        multiMock.addCalloutMock(service.getEndpointURL() + 'sessions', sessionsMock);
        Test.setMock(HttpCalloutMock.class, multiMock);
        test.startTest();
        Map<String,String> returnedResponse = MultpleHttpCallouts.getBlogsAppsSessions();
        system.debug('returnedResponse: ' + returnedResponse);
        //  {success= 0,message =  cannot able to retrive sessions}   
        System.assertEquals(MultpleHttpCallouts.ERROR_CODE, returnedResponse.get('success'), 'code should be: ' + MultpleHttpCallouts.ERROR_CODE);
        System.assertEquals(MultpleHttpCallouts.SESSIONS_RESPONSE_FAIL, returnedResponse.get('message'), 'message should be: ' + MultpleHttpCallouts.SESSIONS_RESPONSE_FAIL);
        test.stopTest();
        

    }
}