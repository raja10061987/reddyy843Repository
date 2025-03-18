({
	fetchContacts : function(component,event,helper) {
		let action = component.get('c.getContacts');
        let accountId = component.get('v.recordId');
        action.setParams({
            acctIds:accountId
        });
        
         action.setCallback(this,function(response){
           var state = response.getState();
            // success,error,incomplete
           if(state === 'SUCCESS')
           {
               var contactList = response.getReturnValue();
               console.log('contactList: ' + JSON.stringify(contactList));
               component.set('v.contactList',contactList);
           }
            else
            {
                alert('error occured while retriving data');
            }
        });
        $A.enqueueAction(action);
	},
    saveContacts : function(component,event,helper)
    {
           var contactList = component.get('v.contactList');
           var saveAction = component.get('c.saveContatcts');
           var recordViewForm = component.find('recordviewForm');
           var recordEditForm = component.find('recordEditForm');
           var btn = event.getSource();
           var btnName = btn.get('v.name');
           var toastEvent = $A.get('e.force:showToast'); // get event
           saveAction.setParams({contList: contactList});
           saveAction.setCallback(this,function(response)
           {
             let state = response.getState();
             if(state === 'SUCCESS')
             {
               let dataMap = response.getReturnValue();
               // one app container
               if(dataMap.status === 'success')
               {
                $A.util.addClass(recordEditForm,'formHide');  
                $A.util.removeClass(recordViewForm,'formHide');
                btn.set("v.label","edit");
                btn.set("v.name","edit");
               // helper.fetchContacts(component,event,helper);
                // set params
                   toastEvent.setParams({
                    'title': 'success!',
                    'type': 'success',
                    'mode': 'dismissable',
                    'message': dataMap.message
                   });

                // fire event
                toastEvent.fire();
                window.location.reload();
               // component.set('v.contactList',contactList);

               }
               else if(dataMap.status === 'error')
               {
                // set params
                toastEvent.setParams({
                    'title': 'error!',
                    'type': 'error',
                    'mode': 'dismissable',
                    'message': dataMap.message
                   });
                // fire event
                toastEvent.fire();


               }

             }
             else
             {
             alert('error occured while updating record');
             }
           });
           $A.enqueueAction(saveAction);
    },
    removeContacts: function(component,event,helper)
    {
      var contactsToDelete = component.find('deleteContact');
        var conIdsList = [];
        if(contactsToDelete.length != undefined)
        { // if it is array
           for (let i = 0; i < contactsToDelete.length; i++) {
            let isContactChecked = contactsToDelete[i].get('v.checked');
            console.log('isContactChecked: ' + isContactChecked);
            if (isContactChecked)
            {
                conIdsList.push(contactsToDelete[i].get('v.value'));
            }
           }
        
        }
        else 
        { // if it is object
            var isMyContactChecked = contactsToDelete.get('v.checked');
            if(isMyContactChecked)
            {
                conIdsList.push(contactsToDelete.get('v.value'));
            }

        }
       console.log('conIdsList: ' + conIdsList);
       if(conIdsList.length == 0)
       {
           alert('please select at least one contact to delete');
           return;
       }
       var deleteAction = component.get('c.removeContacts');  
       deleteAction.setParams({
        contactidsList: conIdsList
       });

       deleteAction.setCallback(this,function(response){
        let returnedState = response.getState();
        let dataMap = response.getReturnValue();
        let toastEvent = $A.get('e.force:showToast');
        console.log('returnedState: ' + returnedState);
        console.log('returned response: ' + response.getReturnValue());
        if(returnedState == 'SUCCESS')
        {
          if(dataMap.status == 'success')
          {
            toastEvent.setParams({
                 "title": 'success!',
                 'mode': "dismissable",
                 'type': "success",
                 'message': dataMap.message
            });
            toastEvent.fire();
            window.location.reload(); // refresh aura page
          }
          else if(dataMap.status == 'error')
          {
            toastEvent.setParams({
              'title': 'error!',
              'type': 'error',
              'mode': 'dismissable',
              'message': dataMap.message
             });
             toastEvent.fire();
            
          }
          
        }
        else
        {
          alert('error occured while deleting contact');
        }





       });
       
       
        $A.enqueueAction(deleteAction);
       
    },
    insertContact: function(component,event,helper)
    {
      let accountId = component.get('v.recordId');
      var contact = component.get('v.contact');
      var toastEvent = $A.get('e.force:showToast'); // get event
      contact.AccountId = component.get('v.recordId');
      console.log('contact Object: ' + JSON.stringify(contact));
      let insertAction = component.get('c.createContact');
      insertAction.setParams({
        conObj: contact
      });

      insertAction.setCallback(this,function(response){
        let state = response.getState();
        if(state == 'SUCCESS')
        {
         let dataMap = response.getReturnValue();
         console.log('dataMap: ' + JSON.stringify(dataMap));
         if(dataMap.status == 'success')
         {
            toastEvent.setParams({
              'title': 'success!!!!',
              'type': 'success',
              'mode': 'dismissable',
              'message': dataMap.message
            });
            toastEvent.fire();
            window.location.reload();
         }
         else if(dataMap.status == 'error')
         {
          toastEvent.setParams({
            'title': 'error!!',
            'type': 'error',
            'mode': 'dismissable',
            'message': dataMap.message
          });
          toastEvent.fire();
    
         }
         window.location.reload();
        }
        else
        {
         alert('error occured while inserting record');
        }
      })

      $A.enqueueAction(insertAction);
    }
})