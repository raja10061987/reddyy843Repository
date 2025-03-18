@RestResource(urlMapping ='/ContactAPI/*')
global class ContactResource
{ 
 
    
    
    
  global class responseWrapper
  {
      string success;
      string message;
  }
    
   // @HttpPatch == example 1
    Global Static Contact updatemyContact()
    {
        system.debug('inside patch method');
        restRequest contactContext = restContext.request;
        system.debug('contactContext: ' + contactContext);
        string contactRequestURI = contactContext.requestURI; // /ContactAPI/0035g00000UxJQi
        string contactId = contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1);  // 0035g00000UxJQi
        system.debug('contactId: ' + contactId);
        string requestBody = contactContext.requestBody.tostring();
        system.debug('requestBody: ' + requestBody);
        Contact contObj = new Contact();
        if(String.isNotEmpty(contactId))
        {
          contObj = (Contact)JSON.deserialize(requestBody, Contact.class);
          contObj.Id = contactId;
            update contObj;
        }
         system.debug('contObj: ' + contObj);
        return contObj;
    }
    
    @HttpPatch // example2
    Global static Hiring_Manager__c updateHRRecord()
    {
     restRequest hrContext = restContext.request;
     string hrRequestURI = hrContext.requestURI;
     system.debug('hrRequestURI: ' + hrRequestURI); // /ContactAPI/a085g000005cg8P
     string hrId = hrRequestURI.substring(hrRequestURI.lastIndexOf('/') + 1);
     system.debug('hrId: ' + hrId);
      string hrRequestBody = hrContext.requestBody.toString();
       system.debug('hrRequestBody: ' + hrRequestBody);
        Hiring_Manager__c hrObj = new Hiring_Manager__c();
        if(String.isNotBlank(hrId))
        {
            system.debug('inside if block');
            hrObj = (Hiring_Manager__c)JSON.deserialize(hrRequestBody, Hiring_Manager__c.class);
            hrObj.Id = hrId;
           system.debug('hrObj: ' + hrObj);
            update hrObj;
        }
        return hrObj;
        
      
    }
    
    
    @HttpDelete
    Global static List<responseWrapper> deleteMultipleContacts()
    {
        List<responseWrapper> responseWrapperList = new List<responseWrapper>(); 
        restRequest contactContext = restContext.request;
        string contactURI = contactContext.requestURI; // /ContactAPI/0035g00000BaM9M,0035g00000CuMIp,0035g00000Baowp
        string[] contactIds = contactURI.substring(contactURI.lastIndexOf('/') + 1).split(',');
        system.debug('contactIds: ' + contactIds);
        List<contact> contactToDelete = new List<Contact>();
        
        for(string conId: contactIds)
        {
            Contact conObj = new Contact(Id=conId);
            system.debug('conObj: ' + conObj);
            contactToDelete.add(conObj);
            system.debug('contactToDelete: ' + contactToDelete);
        }
       Database.DeleteResult[] deleteResults = Database.delete(contactToDelete, false); // partial deletion
        
        system.debug('deleteResults:  ' + deleteResults);
        
        for (Database.DeleteResult deleteResult:deleteResults)
        {
             responseWrapper wrapper = new responseWrapper();   
            if(deleteResult.isSuccess())
            {
                wrapper.success = '1';
                wrapper.message = 'Successfully deleted with contact id: '+ deleteResult.getId();
                system.debug('wrapper: ' + wrapper);
                responseWrapperList.add(wrapper);
            }
            else
            {
                wrapper.success = '0';
                for (Database.error error:deleteResult.getErrors())
                {
                wrapper.message = 'the following error has occured for contact with id: ' + deleteResult.getId();
                wrapper.message +=  error.getStatusCode() + ': ' + error.getMessage() + ':';
                wrapper.message += 'contact fields that effected this error: ' + error.getFields();
                } 
                responseWrapperList.add(wrapper);
            }
            system.debug('responseWrapperList: ' + responseWrapperList);
        }
        return responseWrapperList;
        
        
        
        
    }
    
    @HttpGet
    global static List<Contact> getconatctIdName()
    {
        Restrequest contactRequest = RestContext.request;
        string contRequURI = contactRequest.requestURI; //    /ContactAPI/2
        integer contactLimt = Integer.valueOf(contRequURI.substring(contRequURI.lastIndexOf('/') + 1));
            return [select id,name,phone from contact limit:contactLimt];
    }
    
    
    // one way to insert the record
   // @HTTPPost
   // global static Account createAccount(string actName,string rating,string phone,string type)
    //{
       // Account actObj = new Account();
        //actObj.name = actName;
        //actObj.Rating = rating;
        //actObj.Phone = phone;
        //actObj.Type = type;
        //insert actObj;
        //return actObj;
    // }
    
    
    // second way
     @HttpPost
    global static account insertAccount()
    {
        restRequest accountRequest = restContext.request;
        system.debug('accountRequest: ' + accountRequest);
        string requestBody = accountRequest.requestBody.toString();
        system.debug('requestBody: ' + requestBody);
        account actObj = (account)JSON.deserialize(requestBody, account.class);
        system.debug('conObj: ' + actObj);
        insert actObj;
        return actObj;   
    }
    
    
   // delete single contact
    global static map<string,string> deleteContact()
    {
        map<string,string> resourceMap = new map<string,string>();
        restRequest contactRequest = restContext.request;
        system.debug('contactRequest: ' + contactRequest);
        string contactRequestURI = contactRequest.requestURI;
        system.debug('contactRequestURI: ' + contactRequestURI); // /ContactAPI/0035g00000Fokhh
        integer idIndexposition = contactRequestURI.lastIndexOf('/') + 1;
        system.debug('idIndexposition: ' + idIndexposition);
        Id contactId = Id.valueOf(contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1));
        contact contactToDelete = new contact(Id = contactId);
        system.debug('contactToDelete: ' + contactToDelete);
        try
        {
            delete contactToDelete;
            resourceMap.put('success','1');
            resourceMap.put('message','Record deleted successfully');
            
        }
        catch(dmlException ex)
        {
            resourceMap.put('success','0');
            resourceMap.put('message',ex.getMessage());
        }
        system.debug('resourceMap: ' + resourceMap);
        return resourceMap;
        
        
    }
    
    
}