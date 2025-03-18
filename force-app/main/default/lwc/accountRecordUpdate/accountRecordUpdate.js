import { LightningElement, api } from 'lwc';
import { FlowAttributeChangeEvevt,FlowNavigationNextEvent} from 'lightning/flowSupport';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class AccountRecordUpdate extends LightningElement 
{
    @api
    availableActions = [];
    @api
    accountRecordId;
    objectApiName = 'Account';
    fields = ['Name','Type','Industry'];

    handleSuccess(event)
    {
        console.log('event detail: ' + JSON.stringify(event.detail));
        const toAstEvent = new ShowToastEvent({title: 'Record Update', meesage: 'Record updated successfully', variant: 'success'});
        this.dispatchEvent(toAstEvent);
        this.handleGoNext();
    }

    handleGoNext()
    {
        // check if next allowed in the screen
        if(this.availableActions.find(action => action == 'NEXT'))
        {
             // Navigate to the Next screen
             const navigationNextEvent = new FlowNavigationNextEvent();
              this.dispatchEvent(navigationNextEvent);
        }
    }


}