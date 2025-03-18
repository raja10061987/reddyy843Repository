import { LightningElement, track } from 'lwc';

export default class Animal extends LightningElement {
    name='cat';
    originalage = 1;
    newAge = 0;
    get age()
    {
        if(this.originalage > 20)
        {
            console.log('orizional age is should not be greater than: ' + this.originalage);
            alert('age should not be greater than 20');
         // this.originalage = 20;
         return 20;
        }
        return this.originalage;
    }
    set age(value)
    {
        console.log('setter age value: ' + value);
    //    if(value > 20)
    //    {
    //     alert('invalid age for cata: ' + value);
    //     return;
    //    } 
      this.originalage = value;
    }
    
    updateAge(event)
    {
      this.newAge = event.target.value;
      console.log('newAge: ' + this.newAge);
    }
    updateOriginalAge()
    {
        this.age = this.newAge;
        console.log('update original age');
    }
}