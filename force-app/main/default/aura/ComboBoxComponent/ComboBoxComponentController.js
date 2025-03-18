({
    handleChange : function(component, event, helper) 
    {
        let seletcedOption = component.get('v.selectedOption');
        console.log('seletcedOption: ' + seletcedOption);
        // get event
        let componentEvent = component.getEvent('cmpEvent');
        // set Params
        componentEvent.setParams({'selectedVal': seletcedOption});
        // fire event
        componentEvent.fire();

    }
})