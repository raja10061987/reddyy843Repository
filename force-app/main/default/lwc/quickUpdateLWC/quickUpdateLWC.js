import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
export default class QuickUpdateLWC extends LightningElement 
{
    
    @api recordId;
    @api objectApiName;

    handleSuccess(event)
    {
          // close modal popup window
          this.dispatchEvent(new CloseActionScreenEvent());
          this.dispatchEvent(new ShowToastEvent({title: 'success',message: 'successfully updated with id: ' + event.detail.id,variant: 'success'}));


    }
    connectedCallback()
    {
        console.log('recordId: ' + this.recordId + '<==> ' + 'objectApiName: ' + this.objectApiName);
    }

    handleRest()
    {
        let inputFields = this.template.querySelectorAll('lightning-input-field');
        if(inputFields)
        {
                inputFields.forEach(element => {
                       console.log('value: ' + JSON.stringify(element.value) + 'Name: ' + element.fieldName);
                       // element.value = '';
                       element.reset();
                });
        }
    }

}