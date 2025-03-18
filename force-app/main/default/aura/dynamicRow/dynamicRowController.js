({
    doInit : function(component, event, helper) 
    {
        // create default rowitem[contact instance] on first time component load
        helper.createObjectData(component,event,helper);

    },
    removeDeletedRow: function(component,event,helper)
    {
        let indxposition = event.getParam('indexVar');
        let allContacts = component.get('v.contactList');
        allContacts.splice(indxposition,1);
        component.set('v.contactList',allContacts);
    },
    addNewRow: function(compnent,event,helper)
    {
        // call the commonObjectData method for new row
        helper.createObjectData(compnent,event,helper);
    },
    save: function(component,event,helper)
    {
        if(helper.validationRequired(component,event,helper))
        {
            var action = component.get('c.insertContacts');
            var contactList = component.get('v.contactList');
            action.setParams({'contList': contactList});
            action.setCallback(this,function(response)
            {
                let returnedState = response.getState();
                if(returnedState == 'SUCCESS')
                {
                  component.set('v.contactList',[]);
                  helper.createObjectData(component,event,helper);
                  alert('contact records saved successfully');

                }
                else
                {
                   alert('error occured while inserting records');
                }

            });
            $A.enqueueAction(action);

        }
        else
        {
            alert('contact Name is manadatory');
        }
    }
})