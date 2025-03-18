@isTest
public with sharing class Calculate2NumbersTest 
{
    @isTest
    public static void getsumResultTest()
    {
        test.startTest();
        integer myResult = Calculate2Numbers.getsumResult(10,20);
         System.debug('myResult: ' + myResult);
         system.assertEquals(myResult, 30, 'sum of 2 Numbers should be 30');
        test.stopTest();

    }
   
}