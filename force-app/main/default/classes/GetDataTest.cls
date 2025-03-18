@isTest
public with sharing class GetDataTest 
{

    @isTest
    public static void getMyDataTest()
    {
        integer code = 200;
        string status = 'OK';
        string body = '{"data":[{"id":659,"wikiDataId":"Q1519","type":"CITY","city":"Abu Dhabi","name":"Abu Dhabi","country":"United Arab Emirates","countryCode":"AE","region":"Emirate of Abu Dhabi","regionCode":"AZ","regionWdId":"Q187712","latitude":24.451111111,"longitude":54.396944444,"population":1483000,"distance":null,"placeType":"CITY"},{"id":638,"wikiDataId":"Q530171","type":"CITY","city":"Ajman","name":"Ajman","country":"United Arab Emirates","countryCode":"AE","region":"Emirate of Ajman","regionCode":"AJ","regionWdId":"Q159477","latitude":25.399444444,"longitude":55.479722222,"population":490035,"distance":null,"placeType":"CITY"},{"id":644,"wikiDataId":"Q234600","type":"CITY","city":"Al Ain","name":"Al Ain","country":"United Arab Emirates","countryCode":"AE","region":"Emirate of Abu Dhabi","regionCode":"AZ","regionWdId":"Q187712","latitude":24.2075,"longitude":55.744722222,"population":766936,"distance":null,"placeType":"CITY"},{"id":3704017,"wikiDataId":"Q3696182","type":"CITY","city":"Dibba Al-Fujairah","name":"Dibba Al-Fujairah","country":"United Arab Emirates","countryCode":"AE","region":"Emirate of Fujairah","regionCode":"FU","regionWdId":"Q4091","latitude":25.616667,"longitude":56.266667,"population":41017,"distance":null,"placeType":"CITY"},{"id":3519123,"wikiDataId":"Q612","type":"CITY","city":"Dubai","name":"Dubai","country":"United Arab Emirates","countryCode":"AE","region":"Emirate of Dubai","regionCode":"DU","regionWdId":"Q613","latitude":25.269722222,"longitude":55.309444444,"population":3564931,"distance":null,"placeType":"CITY"}],"metadata":{"currentOffset":0,"totalCount":28602}}';
        Map<String,String> responseHeaders = new Map<String,String>();
        HTTPMockFactory obj = new HTTPMockFactory(code,status,body,responseHeaders);
        Test.setMock(HttpCalloutMock.class,obj);
        Test.startTest();
        List<Data> returnedresponse = GetData.getMyData();
        system.debug('returnedresponse@@: ' + returnedresponse);
        system.assert(!returnedresponse.isEmpty(),'returned response is empty');
        Data reurnedObject = returnedresponse[0];
        system.debug('reurnedObject: ' + reurnedObject);
        
        Test.stopTest();

    }
  
}