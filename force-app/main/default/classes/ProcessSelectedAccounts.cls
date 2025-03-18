public with sharing class ProcessSelectedAccounts 
{
    @InvocableMethod(label='Existing Accounts' description='Processing Existing Accounts' category='Account')
    public static List<Results> prepareLists(List<Requests> requestList)
    {
        system.debug('requestList: ' + requestList);
        List<String> accountIdsList = new List<String>();
        List<Results> responseWrapper = new List<Results>();
        if(requestList.size() > 0 && requestList[0].ContactRecord != null && requestList[0].ContactRecord.Selected_Account_Ids__c != null)
        {
             String existingAccountIDs = requestList[0].ContactRecord.Selected_Account_Ids__c;
             system.debug('existingAccountIDs: ' + existingAccountIDs);
             existingAccountIDs.removeEnd(',');
             accountIdsList.addAll(existingAccountIDs.split(','));
             system.debug('accountIdsList: ' + accountIdsList);
             Results response = new Results();
             response.existingAccountIds = accountIdsList;
             responseWrapper.add(response);
             system.debug('responseWrapper: ' + responseWrapper);
        }
        return responseWrapper;

    }

    public class Requests
    {
        @InvocableVariable(label= 'Record for input' description='yourDescription')
        public Contact ContactRecord;
    }

    public class Results
    {
        @InvocableVariable(label='Records for output' description='yourDescription' required=true)
        public List<String> existingAccountIds;
    }
}