({
    callAuraMethodServerTrip : function(component, event, helper) 
    {
        alert('Hi Component called');
        var childComp = component.find('child');
        childComp.retriveAccounts(function(result) {
            console.log('callback for aura:method executed');
            console.log('result@@: ' + JSON.stringify(result));
            var records = [];
            component.set('v.accountRecords', result);

        },'Contact','Email');

    }
})