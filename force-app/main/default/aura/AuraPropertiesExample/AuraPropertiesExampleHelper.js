({
    LoadAuraHelperObject : function(component,event,helper) 
    {
        let auraPropertisAction = component.get('c.getDetails');
        auraPropertisAction.setCallback(this,function(response)
        {
         let responseState = response.getState();
         if(responseState === 'SUCCESS')
         {
          let resposeObject = response.getReturnValue();
          console.log('resposeObject: ' + JSON.stringify(resposeObject));
          component.set('v.wrapperObj',resposeObject); // {'Comapny': 'infosys','srNumber': '7013948962'}
          // resposeObject: {"companyName":"infosys","industry":"IT","name":"Rajasekhar","srNumber":"7013948962"}
         }
         else
         {
            alert('getting error while returning aura object');
         }
        });
        $A.enqueueAction(auraPropertisAction);

    }
})