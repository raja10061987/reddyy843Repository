import { LightningElement } from 'lwc';

export default class ContactForm extends LightningElement 
{
    contact = {};
    countryOptions = [
        { "label": "Afghanistan", "value": "Afghanistan" },
        { "label": "Albania", "value": "Albania" },
        { "label": "Algeria", "value": "Algeria" },
        { "label": "Andorra", "value": "Andorra" },
        { "label": "Angola", "value": "Angola" },
        { "label": "Antigua & Deps", "value": "Antigua  & Deps"}
    ];
    
    connectedCallback()
    {
        console.log('hello world example');
        
    }

    isInputValid()
    {
      let isValid = true;
      let inputFields = this.template.querySelectorAll('.validate');
      console.log('all inputFields: ' + JSON.stringify(inputFields));
      inputFields.forEach((inputField) => {
       console.log('each inputField: name ' + inputField.name + "<====> value: " + inputField.value);
       if(!inputField.checkValidity())
       {
        inputField.reportValidity();
        isValid = false;
       }
       else
       {
        this.contact[inputField.name] = inputField.value;
       }
      })

      return isValid;


    }

    createContact()
    {
   let isFormValid = this.isInputValid();
   
   if (isFormValid)
   {
      console.log('isFormValid' + isFormValid);
      console.log('contact: ' + JSON.stringify(this.contact));
   }
   else
   {
    console.log('isFormValid: ' + isFormValid);
   }


    }

}