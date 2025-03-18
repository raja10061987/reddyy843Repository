({
    retriveAccounts : function(component, event, helper) 
    {
        var params = event.getParam('arguments');
        var myAction = component.get('c.getAccountRecords');
        var actcallback;
        if(params)
        {
            actcallback = params.callback;
        }
        myAction.setParams({objectName: params.objectName,fields: params.fieldName});

        myAction.setCallback(this,function(response)
        {
          let myState = response.getState();
          if(myState === 'SUCCESS')
          {
            let accountRecords = '';
             accountRecords = response.getReturnValue();
             console.log('accountRecords: ' + JSON.stringify(accountRecords));
        
          actcallback(accountRecords);
          }
          else
          {
            alert('got error while retriving accounts');
          }
        });
        $A.enqueueAction(myAction);
    }
})