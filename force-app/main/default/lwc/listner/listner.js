import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { unregisterAllListeners,registerListener } from 'c/pubsub';
// import pubsub from 'c/pubsub';


export default class Listner extends LightningElement 
{
    message;
    @wire(CurrentPageReference) pageRef;
    connectedCallback()
    { // subscribing or listening event
        registerListener('messagesend',this.handleMessageSend,this);
        // pubsub.register('changeBrand', {result: this.handleMessageSend(this) });
    }
    handleMessageSend(publisherMessage)
    {
     this.message = publisherMessage.myBrand;
     console.log('event listned/subscribed: ' + this.message);
    }
    disconnectedCallback()
    {
        unregisterAllListeners(this);
    }

}