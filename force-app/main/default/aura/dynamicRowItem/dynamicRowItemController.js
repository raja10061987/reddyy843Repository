({
    addNewRow : function(component, event, helper) {
      // get and fire event
      component.getEvent('addRowEvent').fire();
    },
    removeRow: function(component,event,helper)
    {
        component.getEvent('deleteRowEvent').setParams({indexVar: component.get('v.rowIndex')}).fire();
    },
    onLoad: function(component,event,helper)
    {
      let eachContactRecord = component.get('v.contactInstance');
      let eachContactIndex = component.get('v.rowIndex');
      console.log('child component loaded record: ' + JSON.stringify(eachContactRecord) + ' Index: ' + eachContactIndex);
    }
})