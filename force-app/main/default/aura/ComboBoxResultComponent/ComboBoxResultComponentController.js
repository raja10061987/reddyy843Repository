({
    handleAction : function(component, event, helper) 
    {
        let countryValue = event.getParam('selectedVal');
        console.log('countryValue:@@' + countryValue);
        component.set('v.pickListValue',countryValue);

    }
})