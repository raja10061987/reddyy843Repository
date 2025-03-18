({
    createObjectData : function(component,event,helper) 
    {
        // get the contactList from the component and push new object in the List
        var removeItemList = component.get('v.contactList');
        removeItemList.push({'sObjectType': 'Contact','FirstName': '','LastName': '','Phone':''});
        component.set('v.contactList',removeItemList);

    },
    validationRequired: function(component,event,helper)
    {
      var isValid = true;
      var allContactRows = component.get('v.contactList');
      for(var indxVar=0;indxVar < allContactRows.length; indxVar++)
      {
        if(allContactRows[indxVar].FirstName == '')
        {
          isValid = false;
        }
      }
      return isValid;
    }
})