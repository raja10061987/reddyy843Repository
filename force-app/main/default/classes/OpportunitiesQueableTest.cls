@isTest
public class OpportunitiesQueableTest
{
    public static testMethod void OpprtunityEexcuteTest()
    {
        Account actObj = new Account();
        actObj.Name = 'lankaraman123';
        actObj.Rating = 'Hot';
        actObj.Active__c = 'No';
        actObj.AnnualRevenue = 12000;
        actObj.AccountNumber = '123456';
        actObj.BillingCity = 'Hyderabad1';
        actObj.Phone = '7013948962';
        actObj.ShippingCity = 'Hyderabad';
        insert actObj;
        if(actObj.id != null)
        {
            system.debug('account record inserted successfully: ' + actObj.Id);
            system.debug('account record: ' + actObj);
        }
        
    }

}