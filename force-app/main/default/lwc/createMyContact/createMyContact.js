import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import Last_Name_field from '@salesforce/schema/Contact.LastName';
import Phone_field from '@salesforce/schema/Contact.Phone';
import accountId_field from '@salesforce/schema/Contact.AccountId';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin} from 'lightning/navigation';

export default class CreateMyContact extends NavigationMixin(LightningElement) 
{
    name;
    phone;
    selectedAccountId;

    connectedCallback()
    {
        this.name = '';
        this.phone = '';
        this.selectedAccountId = '';
    }



    createContact()
    {
        console.log('selected accountId: ' + this.selectedAccountId);
        console.log('Last_Name_field: ' + JSON.stringify(Last_Name_field));
        console.log('CONTACT_OBJECT: ' + JSON.stringify(CONTACT_OBJECT));
        const fields= {};
         fields[Last_Name_field.fieldApiName] = this.name;
         fields[Phone_field.fieldApiName] = this.phone;
         fields[accountId_field.fieldApiName] = this.selectedAccountId; // {LastName:raja,Phone:1222,accountId:001jcbs}
         const recordInput = {apiName: CONTACT_OBJECT.objectApiName, fields}; // {apiName: Contact,fields: {LastName:raja,Phone:1222,accountId:001jcbs}}
         console.log('recordInput: ' + JSON.stringify(recordInput));
         createRecord(recordInput)
         .then(contObj => 
            {

            this.dispatchEvent(new ShowToastEvent({
                title: 'success',
                message: 'contact record successfully created with id: ' + contObj.id,
                variant: 'success'
            }));

            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: contObj.id,
                    objectApiName: 'Contact',
                    actionName: 'view'
                },
            });


         })
         .catch(error => {
              this.dispatchEvent( new ShowToastEvent({title: 'error',message: 'error occured', variant: 'error'}));
         })
    }
    handleChange(event)
    {
      if(event.target.label == 'LastName')
      {
       this.name = event.target.value;
      }
      else if(event.target.label == 'Phone')
      {
         this.phone = event.target.value;
      }
    }

    handleSelected(event)
    {
      this.selectedAccountId = event.detail;
      console.log('selectedAccountId: ' + this.selectedAccountId); 
    }
}