({
    onLoadCallMethod : function(component, event, helper) 
    {
        let quickAction = component.get('c.createContactWithAccountDetails');
        let accountId = component.get('v.recordId');
        console.log('accountId: ' + accountId);
        quickAction.setParams({'accountId': accountId});
        quickAction.setCallback(this,function(response)
        {
            let myState = response.getState();
            if(myState === 'SUCCESS')
            {
            let contactId = response.getReturnValue();
            console.log('inserted contact Record Id: ' + contactId);
            var dismissActionPannel = $A.get('e.force:closeQuickAction');
            dismissActionPannel.fire(); // closing quickAction
            var resultToast = $A.get('e.force:showToast');
            resultToast.setParams({'title': 'Saved','message': 'the record Saved'});
            resultToast.fire(); // show toast message
            $A.get('e.force:refreshView').fire(); // refresh complete aura page
            }
            else
            {
                alert('error accoured while creating Contact Record');
            }

        });

        $A.enqueueAction(quickAction);

    },
    saveContactRecord: function(component,event,helper)
    {
        let saveAction = component.get('c.createContact');
        let accountRecordId = component.get('v.recordId');
        component.set('v.contObj.AccountId',accountRecordId);
        let contObj = component.get('v.contObj');
        console.log('contObj: ' + JSON.stringify(contObj));
        saveAction.setParams({'conObj': contObj});
        saveAction.setCallback(this,function(response){
         let myState = response.getState();
         let returnedContactId = response.getReturnValue();
         console.log('returnedContactId: ' + returnedContactId);
         if(myState === 'SUCCESS')
         {
          let myQuicAction = $A.get('e.force:closeQuickAction');
          myQuicAction.fire();
          let showToaseEvent = $A.get('e.force:showToast');
          showToaseEvent.setParams({'title': 'save','message': 'Contact Record Saved Successfully'});
          showToaseEvent.fire();
          let refreshAuraPage = $A.get('e.force:refreshView');
          refreshAuraPage.fire();
         }
         else
         {
            alert('error occured while creating Contact');
         } 
        });
        $A.enqueueAction(saveAction);

    }
})