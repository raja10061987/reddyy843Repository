({
    getResult : function(component, event, helper) 
    {
       let sumResult = event.getParam('sumResult');
       console.log('sumResult: ' + sumResult);
       component.set('v.result',sumResult);

    }
})