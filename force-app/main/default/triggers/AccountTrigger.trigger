trigger AccountTrigger on Account (before insert,after insert) 
{
       
       if(trigger.isAfter && trigger.isInsert)
       {
        System.debug(' after insert trigger executed');
       // AccountActionHandler.accountAfterInsert(trigger.New);
       AccountActionHandler.updateUserRole();

       }
    // scenario 1 --> before inserting record, prepopulating fields on same record
    List<Account> actList = trigger.New;
    System.debug('actList: ' + actList);
    system.debug('isBefore: ' + trigger.isBefore);
    system.debug('isbfore isnert: ' + trigger.isInsert);

    if(trigger.isBefore && trigger.isInsert)
    {
        for(Account actObj: actList)
        {
            if(actObj.AnnualRevenue < 1000)
            {
                actObj.addError('Annual revenue should not be less than 1000');

            }

            if(actObj.ShippingCity == null)
            {
                actObj.ShippingCity = actObj.BillingCity;

            }
            if(actObj.ShippingCountry == null)
            {
                actObj.ShippingCountry = actObj.BillingCountry;

            }
            if(actObj.ShippingState == null)
            {
                actObj.ShippingState = actObj.BillingState;

            }
            if(actObj.ShippingStreet == null)
            {
                actObj.ShippingStreet = actObj.BillingStreet;
            }

        }

    }

}