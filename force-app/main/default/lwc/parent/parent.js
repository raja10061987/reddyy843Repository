import { LightningElement, track } from 'lwc';

export default class Parent extends LightningElement 
{
     @track message = 'default message';
     @track childMessage;
    sendDataToChild(event)
    {
       this.message = 'Message From Parent';
    }
    HandleData(event)
    {
   this.childMessage = event.detail;
   console.log('parent event handled: ' + event.detail);
    }
}