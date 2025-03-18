({
    calculateTotal : function(component, event, helper) {
        let firstNumber = parseInt(component.get('v.firstNumber'));
        let secondNumber = parseInt(component.get('v.secondNumber'));
        let sum = firstNumber + secondNumber;
      //  let appEvent = component.getEvent('appEvent');
        let appEvent = $A.get('e.c:CalculatorApplicationEvent');
        appEvent.setParams({'sumResult': sum});
        appEvent.fire();

    }
})


// step1: create Application Event
// step2: CalculatorComponent   => Register and fire event
// step3: CalculatorResultComponent ==> using auraHandler , this component listen the event,get the sum value from other component
// step4: calculatorEventExample App