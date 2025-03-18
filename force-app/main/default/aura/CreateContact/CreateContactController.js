({
    saveContact : function(component, event, helper) {
       let saveAction = component.get('c.insertContact');
       let contList = component.get('v.contactList');
       let contObj = component.get('v.contact');
       console.log('contObj@@89: ' + JSON.stringify(contObj));
       saveAction.setParams({'conObj': contObj});
       saveAction.setCallback(this,function(response){
        let returnedState = response.getState();
        if(returnedState === 'SUCCESS')
        {
         let contactId = response.getReturnValue();
         console.log('contact Id: ' + contactId);
         component.set('v.contactId',contactId);
         contList.splice(0,0,contObj);
         component.set('v.contactList',contList);

        }
        else
        {
            alert('error occured while inserting record');
        }
       })
       $A.enqueueAction(saveAction);

    },
    fetchContacts: function(component,event,helper)
    {
        let fetchAction = component.get('c.retriveContacts');
        fetchAction.setCallback(this,function(response)
        {
            let returnedState = response.getState();
            if(returnedState === 'SUCCESS')
            {
              let returnedResponse = response.getReturnValue();
              console.log('returnedResponse: ' + JSON.stringify(returnedResponse));
              component.set('v.contactList',returnedResponse);
            }

        });
        $A.enqueueAction(fetchAction);
     
    }
})