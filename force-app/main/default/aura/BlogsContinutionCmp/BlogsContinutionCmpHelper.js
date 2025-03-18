({
    getData : function(component,event,helper) 
    {
        console.log('BlogsContinutionHelper called');
       var fetchDataAction = component.get('c.fetchData');
       console.log('fetchDataAction: ' + JSON.stringify (fetchDataAction));
       fetchDataAction.setCallback(this,function(response)
       {
        console.log('response state:: ' + response.getState());
        if(response.getState() == 'SUCCESS')
        {
         console.log('response return value: ' + response.getReturnValue());
         var responseData = JSON.parse(response.getReturnValue());
         console.log('response Data: ' +  JSON.stringify(responseData));
         component.set('v.blogdata',responseData.blogData);
         component.set('v.appdata', responseData.appData);
         component.set('v.sessiondata', responseData.sessionData);

        }

       });
       $A.enqueueAction(fetchDataAction);


    }
})