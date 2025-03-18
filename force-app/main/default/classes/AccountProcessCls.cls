public with sharing class AccountProcessCls 
{
    @InvocableMethod(label='insert contacts' description='insert the contacts on account insert')
    public static List<Contact> insertContacts(List<Account> actList)
    {
        system.debug('actList: ' + actList);
        List<Contact> contList = new List<Contact>();
        for (Account actObj : actList) {
            Contact conObj = new Contact();
            conObj.LastName = actObj.Name;
            conObj.accountId = actObj.Id;
            contList.add(conObj);
        }
        insert contList;
        System.debug('contList: ' + contList);
        return contList;

    }
   
}