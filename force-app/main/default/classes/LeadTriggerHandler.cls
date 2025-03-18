public with sharing class LeadTriggerHandler {
   

   public static void InsertCaseAfterInsert(List<Lead> leadList)
   {
     system.debug('leadList: ' + leadList);
    map<String,Id> accountNamewithIdMap = new Map<String,Id>();
set<String> companyNamesList = new set<String>(); // {}
List<Case> caseList = new List<Case>();
system.debug('companyNamesList: ' + companyNamesList);
 for(Lead leadObj:leadList)
 {
  companyNamesList.add(leadObj.Company);
 }
system.debug('companyNamesList: ' + companyNamesList); // {test myAccount}

List<Account> accountsList = [select Name from Account where Name in:companyNamesList WITH SECURITY_ENFORCED];
system.debug('accountsList: ' + accountsList); // (Account: {Id=001asj,Name=test my Account})

for(Account actObj:accountsList)
{
  accountNamewithIdMap.put(actObj.Name,actObj.Id);
}
system.debug('accountNamewithIdMap: ' + accountNamewithIdMap); // {testMyAccount=00136te3}
system.debug('accountNamewithIdMap keyset: ' + accountNamewithIdMap.keyset()); // (testMyAccount)
system.debug('accountNamewithIdMap values: ' + accountNamewithIdMap.values()); // (0015g00001EfZDFAA3)


   for(Lead leadObj: leadList)
   {
    if(accountNamewithIdMap.keyset().contains(leadObj.Company))
    {
      Case casObj = new Case();
      casObj.Status = 'New';
      casObj.Origin = 'Web';
      casObj.Subject = 'Account alrady exist for company: ' + leadObj.Company;
      casObj.AccountId = accountNamewithIdMap.get(leadObj.Company);
      caseList.add(casObj);
    }
    else
    {
      system.debug('compan Name is not exist for any account');
    }

   }
   system.debug('before inserting case record: ' + caseList);
   insert as user caseList;
   system.debug('after insert caseList: ' + caseList);


   }
}