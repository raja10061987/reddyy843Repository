Global with sharing class myContactResource1
{

  webService static List<Contact> getContacts(integer contactLimit)
   {
   
     List<Contact> contList = [select id,name,phone from Contact Limit: contactLimit ];
     
     return contList;
   
   }

}