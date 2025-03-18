({
    getData : function(component) {
         var action = component.get('c.getContacts');
         action.setParams({
            recordId: component.get('v.recordId')
         });
         action.setCallback(this,$A.getCallback(function(response){
            var state = response.getState();
            console.log('state.getReturnValue(): ' + JSON.stringify(response.getReturnValue()));
            if(state == 'SUCCESS')
            {
                component.set('v.data',response.getReturnValue());
            }
            else if(state == 'ERROR')
            {
                var errors = response.getError();
                console.log('errors: ' + errors);

            }
        }));
         $A.enqueueAction(action);
    }
})