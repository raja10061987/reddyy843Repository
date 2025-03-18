({
    subscribe : function(component, event, helper) 
    {
        console.log('subscribe called');
        component.set('v.notifications',[]);
        // get the API Component
        const empAPI = component.find('empAPI');
        // get the channel from the input box
        const channel = '/event/Account_Creation_Event__e';
       // Replay option to get New events
        const replayId = '-1';
        // subscribe to our platform Event
        empAPI.subscribe(channel,replayId,$A.getCallback((eventRecived) => 
        {
            // process event, this is called each time process event
            console.log('eventRecived: ' + JSON.stringify(eventRecived));
            let actName = eventRecived.data.payload.Account_Name__c;
            let phone = eventRecived.data.payload.Phone__c;

            const  notifications = component.get('v.notifications');
            notifications.push({'accountName': actName,phone: phone});
            console.log('notifications: ' + JSON.stringify(notifications));
            component.set('v.notifications',notifications);
            component.set('v.iseventReceived',true);

        })).then((subscription) => {
          // if subcription successfull on the platform Event
          console.log('subscribed channel: ' + subscription.channel);
          // for hold subscription
          // component.set('v.subscription',subscription);
        });


    }
})