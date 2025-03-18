import { api, LightningElement, wire } from 'lwc';
import getsumMyResult from '@salesforce/apex/Calculate2Numbers.getsumResult';

export default class Calculate2Numbers extends LightningElement 
{
    fNumber;
    sNumber;
    result;
    errors;
    @api title;
    @api greeting;


    @wire(getsumMyResult,{})
    mygetResultMethod({error,data})
    {

    }

    handleChange(event)
    {
      if(event.target.name == 'fNumber')
      {
         this.fNumber = event.target.value;
      }
      else if(event.target.name == 'sNumber')
      {
       this.sNumber = event.target.value;
      }
      console.log('fNumber: ' + this.fNumber + '<==>' + 'sNumber: ' + this.sNumber)
    }

    sum2Numbers()
    {
        getsumMyResult({firstNumber: this.fNumber,secondNumber: this.sNumber})
        .then(response => {
            this.result = response;
            console.log('my result: ' + this.result);
        })
        .catch(error => {
          this.errors = error;
          console.log('errors: ' + JSON.stringify(this.errors));
        })

    }
}