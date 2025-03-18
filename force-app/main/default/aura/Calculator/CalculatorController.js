({
	calculate : function(component, event, helper) 
    {
        // 1. without attributes, by using aura:id
        
       // var firstNumber = component.find('fNum').get('v.value');
       // var secondNumber = component.find('sNumb').get('v.value');
        // console.log('firstNumber: ' + firstNumber);
        // console.log('secondNumber: ' + secondNumber);
        // var result = component.find('result');
      //  result.set('v.value',firstNumber + secondNumber);
       // var resultedValue = component.find('result').get('v.value');
      // console.log('resultedValue: ' + resultedValue);
      
        // 2. without attributes, by using attributes
       
       // var firstNumber = component.get('v.fNumber');
       // var secondNumber = component.get('v.sNumber');
       // var result = component.find('result');
       // component.set('v.result',firstNumber + secondNumber);
        
        
        // 3. by using apex class method, sum 2 integers
        
        var firstNumber = component.get('v.fNumber');
        var secondNumber = component.get('v.sNumber');
       var calculateAction = component.get('c.calculateTwoNumbers');
        calculateAction.setParams({
            "firstNumber": firstNumber,
            "secondNumber": secondNumber
        });
        console.log('calculator method called');
        calculateAction.setCallback(this,function(response){
            let returnedState = response.getState();
            if(returnedState === 'SUCCESS')
            {
                let returnedResponse = response.getReturnValue();
                console.log('returnedResponse: ' + JSON.stringify(returnedResponse));
                component.set('v.result',returnedResponse);
            }
            else
            {
                alert('calculator sum got error');
            }
        })
         $A.enqueueAction(calculateAction);
        
        
	}
})