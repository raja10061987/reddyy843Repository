({
	getContactsList : function(component, event, helper) {
		helper.fetchContacts(component,event,helper);
	},
    newContact: function(component,event,helper)
    {
        // get the global event, standerd event
        // global actions
        // dialog box will open one app
        var createContact = $A.get('e.force:createRecord');
        // set params to the event
        createContact.setParams({
            'entityApiName': 'Contact',
            'defaultFieldValues':{
                'AccountId': component.get('v.recordId')
            }
        });
        createContact.fire();
        // fire the event
        
    },
    editContacts: function(component,event,helper)
    {
        var btn = event.getSource();
        var btnName = btn.get('v.name');
        var recordViewForm = component.find('recordviewForm');
        var recordEditForm = component.find('recordEditForm');
        if(btnName == 'edit')
        {
         $A.util.addClass(recordViewForm,'formHide');
         $A.util.removeClass(recordEditForm,'formHide');
         btn.set("v.label","save");
         btn.set("v.name","save");
        }
        else if(btnName == 'save')
        {
          var contactFields = component.find('fieldToValidate');
          var blank = 0;

          if(contactFields.length != undefined)
          { // if it is array

            var allValid = contactFields.reduce(function(validSofar,inputComp)
            {
                inputComp.showHelpMessageIfInvalid();
                return validSofar && inputComp.get('v.validity').valid;
               
            },true);
            if(!allValid)
            {
            blank ++;
            }

          }
          else
          { // if it is Object
            var allValid = contactFields;
            if(!allValid.get('v.validity').valid)
            {
              blank ++;
            }

          }
          if(blank == 0)
          { // if all validations successfull
            helper.saveContacts(component,event,helper);
          }
        }
    },
    deleteContacts: function(component,event,helper)
    {
        helper.removeContacts(component,event,helper);
    },
    openModal: function(component,event,helper)
    {
        var contactModalPopup = component.find('contactModal');
        $A.util.addClass(contactModalPopup,'slds-fade-in-open');
        var contactModalBackDrop = component.find('contactModalBackDrop');
        $A.util.addClass(contactModalBackDrop,'slds-backfrop_open');

    },
    closeModal: function(component,event,helper)
    {
        var contactModalPopup = component.find('contactModal');
        $A.util.removeClass(contactModalPopup,'slds-fade-in-open');
        var contactModalBackDrop = component.find('contactModalBackDrop');
        $A.util.removeClass(contactModalBackDrop,'slds-backfrop_open');

    },
    createContactRecord: function(component,event,helper)
    {
        var isContactValid = component.validateContact(component,event,helper);
        if(isContactValid)
        {
            helper.insertContact(component,event,helper);
        }
    },
    validateContact: function(component,event,helper)
    {
        var allValid = component.find('formFieldToValidate').reduce(function(validSofar,inputComp){
            inputComp.showHelpMessageIfInvalid();
            let inputName = inputComp.get('v.name');
             if(inputName == 'emailField')
             {
                var inputValue = inputComp.get('v.value');
                if(inputValue != 'raja@gmail.com')
                { // setting custom validation
                    console.log(' inputValue validity: ' + JSON.stringify(inputComp.get('v.validity')));
                     inputComp.focus();
                    inputComp.set('v.validity',{valid: false, badInput: true});
                }

             }
            let isInputValid = inputComp.get('v.validity').valid;
            return validSofar && isInputValid;
        },true);
        console.log('allValid: ' + allValid);
       return allValid;

    }
})