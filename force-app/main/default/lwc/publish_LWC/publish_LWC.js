import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccountList';
import { releaseMessageContext,publish,MessageContext } from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/SampleMessageChannel__c';

export default class Publish_LWC extends LightningElement 
{
    result = [];
   // context = createMessageContext();
   @wire(MessageContext)
   messageContext;
    connectedCallback()
    {
        getAccounts()
        .then((response) => 
        {
            // console.log('response: ' + JSON.stringify(response));
           this.result = response; // [{Id:001nmcsa,Name:ravi,Phone:122},{Id:001jdacn,Name:suman,Phone:9999},{}]
        })
        .catch(error => {
           alert('error occured while retriving account Records');
        })
    }

    handleClick(event)
    {
        console.log('accountId: ' + event.target.dataset.recordid);
        const payLoad = {
            recordId:event.target.dataset.recordid,
            recordData: {value: 'palaod from LWC'}
        };
        publish(this.messageContext,SAMPLEMC,payLoad);
    }
    // disconnectedCallback()
    // {
    //     releaseMessageContext(this.context);
    // }
}