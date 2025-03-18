import { LightningElement, track, wire } from 'lwc';
import { MessageContext, releaseMessageContext,APPLICATION_SCOPE,subscribe, unsubscribe } from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/SampleMessageChannel__c';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
export default class Subscriber_lwc extends LightningElement {
   // context = createMessageContext();
   @wire(MessageContext)
   messageContext;
    subscription = null;
    @track receivedMessage = '';
    accountId = '';
    @track objectApiName='Account';
    fields = [NAME_FIELD, REVENUE_FIELD, INDUSTRY_FIELD];
    connectedCallback(){
        this.subscribeMC();
        console.log('connected callback-subsriber');
    }
     subscribeMC() 
     {
        if(this.subscription)
        {
          return null;
        }
        this.subscription = subscribe(this.messageContext, SAMPLEMC, (message) => {
            this.handleMessage(message);
        },{scope: APPLICATION_SCOPE});
        console.log('subscription@122: ' + JSON.stringify(this.subscription));
     }
     handleMessage(message) {       
        console.log('message:::'+JSON.stringify(message));
        this.accountId = message.recordId;
        this.receivedMessage = message ? message.recordData.value : 'no message payload';
       
    }

    disconnectedCallback()
    {
        releaseMessageContext(this.context);
    }
    
}