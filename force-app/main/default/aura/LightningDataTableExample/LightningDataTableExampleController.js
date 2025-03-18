({
    retriveAccounts : function(component, event, helper) 
    {
        component.set('v.myColumns', [
            { label: 'Name', fieldName: 'linkName', 'type': 'url', typeAttributes: {label: {fieldName: 'Name'}, target: '_blank'}},
            {label: 'Industry', fieldName: 'Industry', type: 'text'},
            {label: 'type', fieldName: 'Type', type: 'text'}
        ]);

        let retriveAction = component.get('c.fetchActs');
        retriveAction.setCallback(this,function(response)
        {
          let fetchState = response.getState();
          if(fetchState === 'SUCCESS')
          {
            let accounts = response.getReturnValue();
            accounts.forEach(function(record){
             record.linkName = '/' + record.Id;
             console.log('each record: ' + JSON.stringify(record));
            });
            console.log('accounts: ' + JSON.stringify(accounts)); // [{'Id':'jsah','linkName': "/001bsabxam",Name':'raja','Industry': 'xbbx','Type': 'as'},{'id':'cnmzc','name':'pavan kumat'}]
            component.set('v.actList',accounts);

          }
          else
          {
            alert('error occured while retriving accounts');
          }
        });
        $A.enqueueAction(retriveAction);


    },
    updateselectedRowsCount: function(component,event,helper)
    {
      var selectedRows = event.getParam('selectedRows');
      component.set('v.selectedRowsCount', selectedRows.length);
    }
})