public with sharing class Calculate2Numbers 
{
     @AuraEnabled
    public static Integer getsumResult(integer firstNumber,integer secondNumber)
    {
        Integer sumResult = Integer.valueOf(firstNumber) + Integer.valueOf(secondNumber);
        System.debug('sumResult: ' + sumResult);
        return sumResult;

    }
    
}