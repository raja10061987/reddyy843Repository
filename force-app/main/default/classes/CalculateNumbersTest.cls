@isTest
public with sharing class CalculateNumbersTest 
{

    @isTest
    public static void calculationTest()
    {
        CalculateNumbers obj = new CalculateNumbers();
           obj.firstNumber = 10;
           obj.secondNumber = 20;
         test.startTest();
           obj.sum();
           obj.sub();
           obj.mul();
           obj.div();
         test.stopTest();
    }
   
}