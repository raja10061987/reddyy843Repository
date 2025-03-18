({
    loadContacts : function(component, event, helper) 
    {
        let contactsAction = component.get('c.retriveValues');
        let contactsOptionsArray = [];
        contactsAction.setCallback(this,function(response)
        {
          let contactState = response.getState();
          if(contactState === 'SUCCESS')
          {
           let contactOptionsMap = response.getReturnValue();
           console.log('contactOptionsMap: ' + JSON.stringify(contactOptionsMap));
          for(var key in contactOptionsMap)
          {
           console.log('value: ' + key + '<==> ' + 'label: ' + contactOptionsMap[key]);
           contactsOptionsArray.push({'label': contactOptionsMap[key], 'value': key});

          }
          console.log('contactsOptionsArray: ' + JSON.stringify(contactsOptionsArray));
          component.set('v.options',contactsOptionsArray);
          }
          else
          {
            alert('error occured while retriving contact options');
          }
        });
        $A.enqueueAction(contactsAction);

    }
})