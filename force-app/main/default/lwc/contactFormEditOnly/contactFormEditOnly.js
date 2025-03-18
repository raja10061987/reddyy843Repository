import { LightningElement } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
export default class ContactFormEditOnly extends LightningElement 
{
    objectApiName = CONTACT_OBJECT;
    handleLoad(event)
    {
      console.log('load event fired');
    }
    resetForm(event)
    {
      const fields = this.template.querySelectorAll('lightning-input-field');
      console.log('all fields Reference: ' + JSON.stringify(fields));
      fields.forEach((eachfield) => {
       console.log('eachfield: ' + eachfield.fieldName);
       console.log('==> each field value: ' + JSON.stringify(eachfield.value));
       eachfield.reset();
      });
    }

    handleSubmit(event)
    {
     event.preventDefault(); // stop the default behaviour of the submit
     let fields = event.detail.fields;
     if(fields.MobilePhone === '')
     {  // if mobile is empty, pass the default number
      fields.MobilePhone = '000000000000'; // default mobile number
     }
     console.log('submit event fired');
     
     this.template.querySelector('lightning-record-edit-form').submit(fields); // submitting the form exclusively
    }
    handleSuccess(event)
    {
      console.log('success event fired');
    }
    hadleError(event)
   {
    console.log('error event fired');
        
    }
}