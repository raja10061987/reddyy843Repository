import { LightningElement,api } from 'lwc';
import Contact_FirstName from '@salesforce/schema/Contact.FirstName';
import Contatc_LastName from '@salesforce/schema/Contact.LastName';
import Contact_Email from '@salesforce/schema/Contact.Email';
import Contact_Phone from '@salesforce/schema/Contact.Phone';
import Contact_AccountId from '@salesforce/schema/Contact.AccountId';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class ContactQuickUpdate extends LightningElement 
{
    @api objectApiName;
    @api recordId;
    fields = [Contact_FirstName,Contatc_LastName,Contact_Email,Contact_Phone,Contact_AccountId];

    handleUpdate(event)
    {  // event.detail.fields.LastName.value
      const toastEvent = new ShowToastEvent({
            title: 'Quick Contact Update',
            message: 'Contact Updated successfully Id: ' + event.detail.id + 'Lastname: ' + event.detail.fields.LastName.value,
            variant: 'success'

      });
      this.dispatchEvent(toastEvent);

    }

}