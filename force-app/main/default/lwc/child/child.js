import { LightningElement, api } from 'lwc';

export default class Child extends LightningElement 
{
    @api textMessage;
    connectedCallback()
    {
        console.log('this is child component' + this.textMessage);
    }

    sendMessageToParent(event)
    {
        
        const sendMessageFromChild = new CustomEvent('childmessage',{detail: 'I am from child'});
        this.dispatchEvent(sendMessageFromChild);
        console.log('child event fired');

    }
}