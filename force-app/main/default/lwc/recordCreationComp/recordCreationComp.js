import { LightningElement,api } from 'lwc';
import { FlowNavigationNextEvent,FlowNavigationFinishEvent} from 'lightning/flowSupport';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class RecordCreationComp extends LightningElement 
{
    @api availableActions = [];
    @api objectApiName;
    @api title;
    @api parentRecordId;
    @api recordIdAfterSave;
    @api message;
    @api fields;
    @api parentFieldApiName;
    fieldsList;
   
    connectedCallback()
    {
        if(this.fields)
        {
          this.fieldsList = this.fields.split(','); // 'firsName,LastName,Phone' ==> [firstName,LastName,{hone}]
          console.log('fieldsList: ' + JSON.stringify(this.fieldsList));
        }
    }

    handleSubmit(event)
    {
        event.preventDefault(); // stop the form
        const fields = event.detail.fields;
        fields[this.parentFieldApiName] = this.parentRecordId;
        console.log('fields@@: ' + JSON.stringify(fields));
        this.template.querySelector('lightning-record-form').submit(fields);
    }

    handleSuccess(event)
    {
       const toastEvent = new ShowToastEvent({ title: 'record created',message: this.message + ' with record Id' + event.detail.id, variant: 'success'});
       this.dispatchEvent(toastEvent);
       this.recordIdAfterSave = event.detail.id;
       this.handleGoNext();
    }
    handleError(event)
    {
       console.log('-------------');
       console.log('error occured: ' + JSON.stringify(event));
    }

     handleGoNext()
     {
        if(this.recordIdAfterSave && this.recordIdAfterSave.startsWith('006'))
        { // if it is opprtunity record, finish event
             const finshEvent = new FlowNavigationFinishEvent();
             this.dispatchEvent(finshEvent);
        }
        else if(this.availableActions.find(action => action == 'NEXT'))
        {
          const nextEvent = new FlowNavigationNextEvent();
          this.dispatchEvent(nextEvent);
        }
     }



}