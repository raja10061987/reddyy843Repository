@Restresource(urlMapping = '/mycontactresource1/*')
global class mycontactResource 
{ 
    @HttpGet
    global static List<Contact> getContacts()
    {
        // forming the request
        restRequest  contactContext = restContext.request;
        string contactRequestURI = contactContext.requestURI;
        system.debug('contactRequestURI: ' + contactRequestURI);  // /mycontactresource1/1
       integer contactLimit = Integer.valueOf(contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1));
        List<Contact> contList = [select id,name from contact limit:contactLimit];
        system.debug('contList: ' + contList);
        return contList;
           
    }
    
    @HttpPost
    global static Contact createContact(string firstName,string lastName, string birthDate,string leadSource, string phone,string email)
    {
        Contact conObj = new Contact();
        conObj.FirstName = firstName;
        conObj.LastName = lastName;
        conObj.Birthdate = Date.parse(birthDate);
        conObj.LeadSource = leadSource;
        conObj.Phone = phone;
        conObj.Email = email;
        conObj.AccountId = '0015g00000ED5kd';
        system.debug('conObj: ' + conObj);
        insert conObj;
        return conObj;
        
        
    }
    
    @HttpPatch
    global static Contact updateContact()
    {
        restRequest contactContext = restContext.request;
        system.debug('contactContext: ' + contactContext);
        string contactRequestURI = contactContext.requestURI; // /mycontactresource1/0035g00000UxL7r
        string contactId = contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1);
        system.debug('contactId: ' + contactId);
        string contactRequestBody = contactContext.requestBody.toString();
        system.debug('contactRequestBody: ' + contactRequestBody);
        
        Contact conObj = new Contact();
        if(String.isNotEmpty(contactId))
        {
            conObj = (Contact)JSON.deserialize(contactRequestBody, Contact.class);
            conObj.Id = contactId;
            system.debug('conObj: ' + conObj);
            update conObj;
           
        }
        return conObj;
        
    }
    
    @HttpDelete
    global static Map<string,string>  deleteContact()
    {
        Map<string,string> resourceMap = new Map<string,string>();
        
        restRequest contactContext = restContext.request;
        string contRequestURI = contactContext.requestURI;
        system.debug('contRequestURI:' + contRequestURI); // 
        string contactId = contRequestURI.substring(contRequestURI.lastIndexOf('/') + 1);
        system.debug('contactId: ' + contactId);
        Contact conObj = new Contact();
        if(String.isNotBlank(contactId))
        {
          conObj.Id = contactId;
            system.debug('conObj: ' + conObj);
            try
            {
               delete  conObj;
               resourceMap.put('success','1');
               resourceMap.put('Message','Contact record deleted successfully');
            }
            catch(dmlException ex)
            {
               resourceMap.put('success','0');
               resourceMap.put('Message',ex.getMessage());
            }
        }
        system.debug('resourceMap: ' + resourceMap);
        return resourceMap;
        
        
    }
    
    

}