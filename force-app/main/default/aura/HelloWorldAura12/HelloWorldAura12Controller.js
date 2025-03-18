({
	handleClick : function(component, event, helper) {
		var mycard = component.find("mycard");
        var title = mycard.get("v.title");
        var newLeadValues = ["sravani","pavan","bhavya"]
        var myleads = component.set("v.myleads",newLeadValues);
	}
})