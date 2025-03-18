public class ContactTriggerHandler 
{
    public static boolean isTriggerRan = false;
  
    // logic to prevent a user to create primary contact if there is any existing primary contact
    public static void recursiveTrigger(List<Contact> newContactList)
    {
        List<Contact> contList = new List<Contact>();
        for(Contact newContact: newContactList)
        {
            Contact contObj1 = new Contact();
            contObj1.LastName = newContact.LastName  + ' hello';
            contObj1.Phone = '777777';
            contList.add(contObj1);
        }
        system.debug('contList size: ' + contList.size());
        system.debug('contList: ' + contList);
        insert as user contList; // (Contact: {Id=003jjhvj,LastName=suman,Phone=666},Contact: {Id=003jjhvj,LastName=suman,Phone=666})
    }
    
}