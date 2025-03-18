({
    getdata : function(component,event,helper) 
    {
        console.log('getData Helper called');
        console.log('getData Helper called12');
        var fetchDataAction = component.get('c.fetchData');
        fetchDataAction.setCallback(this, function(response)
        {
            var state =  response.getState();
            console.log('state: ' + state);
            if (state == 'SUCCESS')
            {
                var responseData = JSON.parse(response.getReturnValue());
                console.log('responseData: ' + JSON.stringify(responseData));
                component.set('v.blogdata', responseData.blogData);
                component.set('v.appData', responseData.appData);
                component.set('v.sessiondata', responseData.sessionData);
             
            }

        });
        
        $A.enqueueAction(fetchDataAction);

    }
})