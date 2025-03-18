({
    geTrecords : function(component, event, helper) 
    {
        let getAction = component.get('c.getAccounts');
        getAction.setCallback(this,function(response){
         let returnedState = response.getState();
         if(returnedState === 'SUCCESS')
         {
           let returnedAccounts = response.getReturnValue();
           console.log('returnedAccounts: ' + JSON.stringify(returnedAccounts));
           component.set('v.actList', returnedAccounts);
         }
         else
         {
            alert('error occured while retriving records');
         }
        });
        $A.enqueueAction(getAction);

    },
    handleClick: function(component,event,helper)
    {
        console.log('accountId: ' + event.target.dataset.value);
        event.preventDefault();
        let payLoad = {
            recordId: event.target.dataset.value,
            recordData: {value: 'getting recordId Through Message Channel'}
        };

        component.find('LMSID').publish(payLoad);

    }
})