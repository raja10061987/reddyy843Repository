@isTest
public with sharing class CityZipGeneratorTest 
{
    @isTest
    public static void getcityZipTest()
    {
        integer code=201;
        string status = 'OK';
        string body1 = '{"country abbreviation": "US",'
               +
               '"places":'
               +
               '[{"place name":"Mankato","longitude":"-93.996","post code":"56001","latitude":"44.1538"},{"place name":"Mankato","longitude":"-94.0698","post code":"56002","latitude":"44.056"},{"place name":"Mankato","longitude":"-94.0942","post code":"56003","latitude":"44.2172"},{"place name":"Mankato","longitude":"-94.0698","post code":"56006","latitude":"44.056"}],'
               +
               '"country":"United States","place name":"Mankato","state":"Minnesota","state abbreviation":"MN"}';
        Map<String,String> httpheaders = new Map<String,String>();
        
        HTTPMockFactory mockObj = new HTTPMockFactory(code,status,body1,httpheaders);
        Test.setMock(HttpCalloutMock.class,mockObj);
        Test.startTest();
        List<CityZip> returnedresponse = CityZipGenerator.getcityZip(); // (CityZip:[places=(Place:[],Place:[])])
        system.assert(!returnedresponse.isEmpty(),'returned response should not be empty');
        CityZip returnedObj = returnedresponse[0];
        system.assertEquals('United States',returnedObj.country,'cuntry should be united states');
        Test.stopTest();

    }   
}