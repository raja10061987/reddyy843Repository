({
    doInit : function(component, event, helper) 
    {
      component.set('v.columns',[
        {label: 'Id',fieldName:'id', type: "text"},
        {label: 'Title',fieldName: 'title', type: "text"},
        {label: 'URL', fieldName: 'url', type: "text"}
      ])

      console.log('doInit controller Method called');
      helper.getData(component,event,helper);

    }
})