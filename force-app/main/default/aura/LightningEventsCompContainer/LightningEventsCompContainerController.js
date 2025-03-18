({
	doInit : function(component, event, helper) {
        component.set('v.myColumns',[
                { label: 'Sno.', fieldName:'sno', type: 'number'},
            { label:'source1',fieldName:'source', type: 'text'},
                { label: 'amount', fieldName:'amount', type:'number'}
            ]);
        component.set('v.incomes', [
            {sno:1,source:'Regular Job',amount:10000},
            {sno:2, source:'part time job',amount: 5000},
            {sno:3, source:'job3',amount: 8000}
        ]);
        var incomes = component.get('v.incomes');
        console.log('on page load incomes: ' + JSON.stringify(incomes));
            
	},
    handleRegisteredComponentEvent: function(component,event,helper)
    {
        console.log('event fired');
        alert('event handler at source component that fired the event');
    },
    addIncome:function(component,event,helper)
    {
        // get all the income records which all are present
        var incomes = component.get('v.incomes');
        console.log('orizonal incomes: ' + JSON.stringify(incomes));
        // get the income source and smount records from the form
        var newIncome = {
            sno: incomes.length + 1,
            source: component.find('source').get('v.value'),
            amount:component.find('amount').get('v.value')
        };
        
        if(newIncome.source != '' && newIncome.amount != '' && newIncome.source != null && newIncome.amount != null)
        {
            incomes.push(newIncome);
            console.log('after pushing new income record: ' + JSON.stringify(incomes));
            component.set('v.incomes',incomes);
            component.find('source').set('v.value','');
            component.find('amount').set('v.value','');
        }
    },
    firetotalIncomeComponentEvent: function(component,event,helper)
    {
        var incomes = component.get('v.incomes');
        let totalIncome = 0;
        for(let i=0; i<incomes.length;i++)
         {
                totalIncome+= parseInt(incomes[i].amount);
         }
        console.log('totalIncome: ' + totalIncome);
       var totalIncomeComponentEvent = component.getEvent('totalIncomeComponentEvent');
        totalIncomeComponentEvent.setParams({
            totalIncome: totalIncome 
        });
        totalIncomeComponentEvent.fire();
    },
    toggleIncomeForm: function(component,event,helper)
    {
        let incomeForm = component.find('incomeForm');
        $A.util.toggleClass(incomeForm,'hide');
        console.log('incomeForm: ' + incomeForm);
    }
})