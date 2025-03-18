import { LightningElement,wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
 import { fireEvent } from 'c/pubsub';



export default class Publisher extends LightningElement 
{
    @wire(CurrentPageReference) pageRef;
    brand = 'IPhone_13';

    publishMessage(event)
    {
      fireEvent(this.pageRef, 'messagesend',{myBrand: this.brand});
      console.log('fired/published message@@');
    }
}