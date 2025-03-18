import { LightningElement,track } from 'lwc';
import {subscribe,unsubscribe,onError,setDebugFlag,isEmpEnabled } from 'lightning/empApi';

export default class PlatformEventExample extends LightningElement 
{
    channelName = '/event/Record_Create__e';
    subscription = {};
    @track accountNameList = [];

    connectedCallback()
    {
      this.handleSubScribe();
    }

    handleSubScribe()
    {
        subscribe(this.channelName,'-1', this.messageCallBack)
        .then(response => 
            {
            console.log('response: ' + JSON.stringify(response));
            this.subscription = response;
           });
    }
    disconnectedCallback()
    {
           this.handleUnsubscribe();
    }

    handleUnsubscribe()
    {
      unsubscribe(this.subscription, response => {
         console.log('unsubscribed response: ' + JSON.stringify(response));
      });       
    }

       messageCallBack = (response) => {
        let actName = response.data.payload.Record_Name__c;
        let actId = response.data.payload.Record_Id__c;
        let recPath = '/' + response.data.payload.Record_Id__c;
        this.accountNameList.push({'Id': actId,'Name': actName,'path': recPath});
        console.log('accountNameList: ' + JSON.stringify(this.accountNameList));
       }


}