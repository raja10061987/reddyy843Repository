import { LightningElement } from 'lwc';
import Account_Name from '@salesforce/schema/Account.Name';
import Account_Industry from '@salesforce/schema/Account.Industry';
import Account_Rating from '@salesforce/schema/Account.Rating';
import Account_Type from '@salesforce/schema/Account.Type';
import {ShowToastEvent}  from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation';




export default class AccountCreationSampleComponent extends NavigationMixin(LightningElement) 
{
    objectApiName = 'Account';
    fields = [Account_Name,Account_Industry,Account_Type,Account_Rating];
    handlesuccess(even)
    {
        console.log('event Detail: ' + JSON.stringify(even.detail));
        const event = new ShowToastEvent({
            title: 'Account Create',
            message: 'record Id: ' + even.detail.id,
            variant: 'success'
        });
       this.dispatchEvent(event);

       this[NavigationMixin.Navigate](
        {
            type: 'standard__recordPage',
            attributes: {
                 recordId: even.detail.id,
                 objectApiName: this.objectApiName,
                 actionName: 'view'
            }
        }
       )
        
    }
}