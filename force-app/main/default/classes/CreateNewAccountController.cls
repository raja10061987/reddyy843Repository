public class CreateNewAccountController 
{
    public string accountRecordStatus {get;set;}
    public  void createNewAccount()
    {
        Account actObj = new Account();
        actObj.AccountNumber = '8309351867';
        actObj.Name = 'Rajasekhar account';
        actObj.Rating = 'Hot';
        actObj.Active__c = 'Yes';
        actObj.Phone = '830937889';
        insert actObj;
        if(actObj.Id != null)
        {
            system.debug('account record created successfully: ' + actObj.Id);
            accountRecordStatus = 'account record created successfully: ' + actObj.Id;
        }
        
    }

}