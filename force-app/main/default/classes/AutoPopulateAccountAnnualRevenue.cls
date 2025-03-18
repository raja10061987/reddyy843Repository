public class AutoPopulateAccountAnnualRevenue 
{
    public static void AccountAnnualRevenue(List<Account> actList)
    {
         for(Account actObj:actList)
        {
            
            if(actObj.Industry == 'Banking'){
              //  system.debug('account Industry: ' + actObj.Industry);
                actObj.AnnualRevenue = 2000;
            }
            else if(actObj.Industry == 'Finance')
            {
                // system.debug('account Industry: ' + actObj.Industry);
                actObj.AnnualRevenue = 3000;
            }
            else if(actObj.Industry == 'Insurance')
            {
                // system.debug('account Industry: ' + actObj.Industry);
                actObj.AnnualRevenue = 4000;
            }
            else if(actObj.Industry == 'HealthCare')
            {
                // system.debug('account Industry: ' + actObj.Industry);
                actObj.AnnualRevenue = 5000;
            }else {
                // system.debug('account Industry: ' + actObj.Industry);
                actObj.AnnualRevenue = 6000;
            }
            
        }
    }
    
    public static void preventDeleteionActiveAccountRecords(List<Account> actList)
    {
        for(Account actRecord:actList)
         {
             // system.debug('actList: ' + actRecord);
             // system.debug('Name: ' + actRecord.name);
             // system.debug('active: ' + actRecord.Active__c);
             if(actRecord.Active__c == 'Yes'){
                 actRecord.addError('you don\'t have access to delete the records');
                 // actRecord.addError('you do not authorized to delete the active records');
                
             }
             
         }
        
    }
    
    public static void preventdeletionContacts(set<Id> actIdList)
    {
        List<contact> contactList = [select id,Lastname,name,accountId from contact where accountId=:actIdList];
        
        if(!contactList.isEmpty())
        {
            for(Contact conRecord:contactList){
                system.debug('befoe nullifiing conRecord: ' + conRecord);
                conRecord.AccountId = null;
            }
            update contactList;
           system.debug('after nullfying conrecord: ' + contactList);
            
        }
    }
    
    public static void synchronizAccountPhoneTax(set<Id> actidList)
    {
        List<Account> actList = [select id,phone, fax,(select id,phone,fax from contacts) 
                                                       from account 
                                                         where Id=:actidList];
        List<Contact> contactsToUpdate = new List<Contact>();        
        if(!actList.isEmpty())
        {
            for(Account actRecord:actList)
            {
                if(!actRecord.Contacts.isEmpty())
                {
                    for(Contact conRecord:actRecord.Contacts)
                    {
                        conRecord.phone = actRecord.Phone;
                        conRecord.Fax = actrecord.Fax;
                        contactsToUpdate.add(conRecord);
                    }
                }
            }
            if(!contactsToUpdate.isEmpty())
            {
                system.debug('contactsToUpdate: ' + contactsToUpdate);
                update contactsToUpdate;
            }
        }
    }
}