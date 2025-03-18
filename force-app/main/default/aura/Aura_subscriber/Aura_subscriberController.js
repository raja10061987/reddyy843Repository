({
    HandleMessage : function(component, event, helper) 
    {
        console.log('retrived accountId: ' + JSON.stringify(event) + 'recordId: ' + event._params.recordId);
        if(event != null)
        {
            let recordId = event.getParam('recordId');
            component.set('v.recordId', recordId);
        }
    }
})