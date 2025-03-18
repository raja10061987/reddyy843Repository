({
    applyColortoText : function(component, event, helper) {
        let myColorCode = event.getParam('colorValue');
        console.log('retrived color code Value: ' + myColorCode);
        component.set('v.colorCodeText',myColorCode);
    }
})