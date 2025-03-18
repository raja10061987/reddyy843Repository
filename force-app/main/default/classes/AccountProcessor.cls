public class AccountProcessor {
    
    @future
    public static void countthecontacts(set<Id> accountIds){
        List<Account> accountList = [select id,name,(select id,name from contacts) from account where Id in: accountIds];
        for(Account actObj:accountList){
            List<Contact> contList = new List<Contact>();
            contList = actObj.contacts;
            actObj.No_Of_Contacts__c = contList.size();
        }
        update accountList;
    }

}