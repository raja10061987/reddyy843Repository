import { LightningElement } from 'lwc';

export default class CalculatorExample extends LightningElement 
{
    firstNumber = 0;
    secondNumber = 0;
    result;
    handleChanges(event)
    {
      if(event.target.name == 'firstNumber')
      {
        this.firstNumber = event.target.value;
        console.log('first Number: ' + this.firstNumber);
      }
      else if(event.target.name == 'secondNumber')
      {
         this.secondNumber = event.target.value;
         console.log('second Number: ' + this.secondNumber);
      }
      // this.result = parseInt(this.firstNumber) + parseInt(this.secondNumber);
    }
    addTwoNumbers()
    {
        this.result = parseInt(this.firstNumber) + parseInt(this.secondNumber);
    }
}