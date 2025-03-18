({
    loadObjectRecords : function(component, event, helper) 
    {
        component.set('v.columns', [
            { label: 'Name', fieldName: 'Name', type: 'text'}
        ]);
       helper.loadObjectRecordsHelper(component,event,helper);
    }
})