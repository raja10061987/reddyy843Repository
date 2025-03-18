public class CalculatorControler 
{
    @AuraEnabled
    public static decimal calculateTwoNumbers(decimal firstNumber,decimal secondNumber)
    {
        system.debug('firstNumber: ' + firstNumber);
        system.debug('secondNumber: ' + secondNumber);
        decimal result = firstNumber + secondNumber;
        system.debug('result: ' + result);
        return result;
        
    }

}