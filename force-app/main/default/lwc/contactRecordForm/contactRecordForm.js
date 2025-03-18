import { LightningElement } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import Mobile_PHONE_FIELD from '@salesforce/schema/Contact.MobilePhone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import BUDGET_FIELD from '@salesforce/schema/Contact.Budget__c';
import BIRTHDATE_FIELD from '@salesforce/schema/Contact.Birthdate';

export default class ContactRecordForm extends LightningElement 
{
    objectName = CONTACT_OBJECT;
    objectFields = [
        FIRST_NAME_FIELD,
        LAST_NAME_FIELD,
        Mobile_PHONE_FIELD,
        EMAIL_FIELD,
        BUDGET_FIELD,
        BIRTHDATE_FIELD
    ];
    // objectFields = ['FirstName','LastName','Email','Birthdate','Budget__c','MobilePhone'];
    handleLoad(event)
    {
      console.log(event.type);
      console.log (JSON.stringify(event.detail));
      // alert(event.type);
    }
    handleSuccess(event)
    {
     // alert(event.type);
     console.log(event.type);
     console.log (JSON.stringify(event.detail));

    }
    handleError(event)
    {
      // alert(event.type);
      console.log(event.type);
      console.log (JSON.stringify(event.detail));
    }
    handleSubmit(event)
    {
     // alert(event.type);
     console.log(event.type);
     console.log (JSON.stringify(event.detail));
    }
    handleCancel(event)
    {
        // alert(event.type);
        console.log(event.type);
        console.log (JSON.stringify(event.detail));
    }


}