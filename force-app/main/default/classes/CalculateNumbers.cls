public with sharing class CalculateNumbers 
{
    public decimal firstNumber {get;set;}
    public decimal secondNumber {get;set;}
    public decimal result {get;set;}
    public void sum()
    {
        result = firstNumber + secondNumber;
        System.debug('result:add  ' + result);
    }
    public void sub()
    {
        result = firstNumber - secondNumber;
        System.debug('result sub: ' + result);
    }
    public void mul()
    {
        result = firstNumber * secondNumber;
        System.debug('result mul: ' + result);
    }
    public void div()
    {
        result = firstNumber / secondNumber;
        System.debug('result div: ' + result);
    }
    
}