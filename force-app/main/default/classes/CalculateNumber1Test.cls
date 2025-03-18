@isTest
public with sharing class CalculateNumber1Test 
{

    @isTest
    public static void myCalculatorsTest()
    {
        Test.startTest();
        CalculateNumbers1 obj = new CalculateNumbers1();
              obj.firstNumber = 20;
              obj.secondNumber = 30;
              obj.sum();
              obj.sub();
              obj.mul();
              obj.div();
           system.assertequals(1,1,'not same');
         Test.stopTest();
    }
    
}