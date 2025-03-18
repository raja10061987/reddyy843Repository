({
    doInt : function(component, event, helper) {
        var userInput = component.get('v.selectedRowsList');
        component.set('v.validate',function()
        {
            // if(userInput && userInput.length > 0)
            // {
            //     return {isValid: true};

            // }
            // else 
            // {
            //     return {isValid: false,errorMessage: 'A value is required..'};
            // }

        });

        component.set('v.columns',[
            {label:'Contact Name', fieldName: 'Name',type:'text'},
            {label:'Phone',fieldName: 'Phone', type:'Phone'},
            {Label:'Email', fieldName: 'Email', type:'Email'}
        ]);
        helper.getData(component);
    },
    getSelectedRecord: function(component,event,helper)
    {
        var selectedRows = event.getParam('selectedRows');
        component.set('v.selectedRowsList',selectedRows);
        let ids;
        for(let i = 0; i < selectedRows.length;i++)
        {
            if(!ids)
            {
                ids = selectedRows[i].Id;

            }
            else
            {
                ids += ',' + selectedRows[i].Id;
            }
        }
        console.log('ids: ' + ids);
        component.set('v.selectedRows',ids);
    }
})