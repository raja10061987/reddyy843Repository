@isTest
public class CalculatorTest 
{
    public static integer x = 6;
    public static integer y = 3;
    
    public static testMethod void addCallOutTest()
    {
        test.startTest();
        test.setMock(webServiceMock.class, new CalculatorMock(CalculatorMock.ADD_MODE));
        Calculator.CalculatorSoap calObj = new Calculator.CalculatorSoap();
        integer actual = calObj.add(x,y);
        system.debug('add result: ' + actual);
        integer expected = X + y;
        System.assertEquals(expected, actual, 'add result shoul be: ' + expected);
        test.stopTest();
    }
    public static testMethod void subCallOutTest()
    {
        test.startTest();
        test.setMock(webServiceMock.class, new CalculatorMock(CalculatorMock.SUB_MODE));
        Calculator.CalculatorSoap calObj = new Calculator.CalculatorSoap();
        integer actual = calObj.Subtract(x,y);
        system.debug('sub result: ' + actual);
        integer expected = X - y;
        System.assertEquals(expected, actual, 'sub result shoul be: ' + expected);
        test.stopTest();
    }
    
    public static testMethod void mulCallOutTest()
    {
        test.startTest();
        Test.setMock(WebServiceMock.class, new CalculatorMock(CalculatorMock.MUL_MODE));
         Calculator.CalculatorSoap calObj = new Calculator.CalculatorSoap();
        integer result = calObj.Multiply(x,y);
        integer exceptedResult = x * y;
        System.assertEquals(exceptedResult, result, 'mul should be: ' + exceptedResult);
        test.stopTest();
    }
    @isTest
     public static  void divCallOutTest()
    {
        test.startTest();
        Test.setMock(WebServiceMock.class, new CalculatorMock(CalculatorMock.DIV_MODE));
         Calculator.CalculatorSoap calObj = new Calculator.CalculatorSoap();
        integer result = calObj.Divide(x,y);
        integer exceptedResult = x / y;
        System.assertEquals(exceptedResult, result, 'DIV should be: ' + exceptedResult);
        test.stopTest();
    }

}