({
      addHelper: function(component,event,helper)
      {
        let firstNumber = parseInt(component.get('v.fNumber'));
      let secondNumber = parseInt(component.get('v.sNumber'));
     // component.set('v.result', firstNumber + secondNumber);
     var calAction = component.get('c.calculateTwoNumbers');
     calAction.setParams({'firstNumber': firstNumber, 'secondNumber': secondNumber});
     calAction.setCallback(this,function(response)
     {
      let calState = response.getState();
      if(calState === 'SUCCESS')
      {
      let addResponse = response.getReturnValue();
      console.log('addResponse: ' + addResponse);
      component.set('v.result',addResponse);
      }
      else
      {
        alert('error occured while adding 2 numbers');
      }
     })
     $A.enqueueAction(calAction);

      }        
})