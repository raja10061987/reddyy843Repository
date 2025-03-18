({
    loadObjectRecordsHelper : function(component,event,helper) 
    {
        let objectAction = component.get('c.retriveData');

        let ObjectName = component.get('v.sObjectName');
        objectAction.setParams({sObjectName: ObjectName});
        objectAction.setCallback(this,function(response)
        {
            let myState = response.getState();
            if(myState === 'SUCCESS')
            {
            let myResponse = response.getReturnValue();
            console.log('myResponse: ' + JSON.stringify(myResponse)); // [{'Id':'001cnzsmn','Name':'pavan'},{'Id': '001bjzx','Name': 'suman'}]
            component.set('v.recordList',myResponse);
            }
            else
            {
                alert('got error while retriving Object Records');
            }

        });
        $A.enqueueAction(objectAction);

       

    }
})