public with sharing class CalculateNumbers1 {
    public decimal firstNumber {get;set;}
    public decimal secondNumber {get;set;}
    public decimal result {get;set;}

    public void sum()
    {
        result = firstNumber + secondNumber;
        System.debug('sum: ' + result);
    }

    public void sub()
    {
        result = firstNumber - secondNumber;
        System.debug('sub: ' + result);
    }
    public void mul()
    {
        result = firstNumber * secondNumber;
        System.debug('mul: ' + result);
    }
    public void div()
    {
        if(firstNumber != 0 && secondNumber != 0){
            result = firstNumber / secondNumber;
        }
       
        System.debug('div: ' + result);
    }
}