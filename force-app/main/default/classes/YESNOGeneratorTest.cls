@isTest
public with sharing class YESNOGeneratorTest {
    
    @isTest
    public static  void getYesNoTest()
    {
        HTTPMockFactory mock= new HTTPMockFactory(200,'OK', 
        '{'
        +
        '"answer":"no"'
        +
        ','
        +
        '"forced":false'
        +
        ','
        +
        '"image":"https://yesno.wtf/assets/no/28-e19b6f658f621f7c5980a33f8249a65d.gif"'
        +
        '}',
        New Map<String,String>()
        );

        Test.setMock(HttpCalloutMock.class,mock);
        Test.startTest();
        List<YesNo> returnedYesNos = YESNOGenerator.getYesNo();
        Test.stopTest();
        system.debug('returnedYesNos: ' + returnedYesNos);
        system.assert(!returnedYesNos.isEmpty(), 'it should not be empty');
        YesNo returnedYesNo = returnedYesNos[0];
        system.assertEquals('no',returnedYesNo.answer,'both are not equal');

    }
}