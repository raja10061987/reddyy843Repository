@RestResource(urlMapping='/ContactAPI1/*')
Global class ContactResource1 
{     
    @HttpGet
     global static List<contact> geContacts()
     {
         RestRequest contactRestContext = RestContext.request;
         system.debug('contactRestContext: ' + contactRestContext);
         map<string,string> contactParams = contactRestContext.params;
         system.debug('contactParams: ' + contactParams);
         string leadSource = contactParams.get('leadSoucrce');
         integer contactLimit = integer.valueOf(contactParams.get('Limit'));
         system.debug('leadSource: ' + leadSource);
         system.debug('contactLimit: ' + contactLimit);
      List<Contact> contList = [select id,name,LeadSource from contact where LeadSource =:leadSource limit:contactLimit];
      system.debug('contList: ' + contList);
      return contList;
     }
    Global class responseWrapper
    {
        string success;
        string message;
    }
    // @HTTPPatch
    global static List<responseWrapper> updateContacts()
    {
        List<responseWrapper> responsewrapperList = new List<responseWrapper>();
        restRequest contactContext = restContext.request;
        // system.debug('contactContext: ' + contactContext);
        string contactRequestBody = contactContext.requestBody.tostring();
       // system.debug('contactRequestBody: ' + contactRequestBody);
          List<Contact> contList = (List<Contact>)JSON.deserialize(contactRequestBody, List<Contact>.class);
        system.debug('contList: ' + contList);
        
       Database.SaveResult[] databaseSaveResults = Database.update(contList, false); // partial updation
        system.debug('databaseSaveResults: ' + databaseSaveResults);
        
        for( Database.SaveResult  databaseSaveResult:databaseSaveResults)
        {
            responseWrapper wrapper = new responseWrapper();
            if(databaseSaveResult.isSuccess())
            {
               wrapper.success = '1'; 
               wrapper.message = 'updated successfully with id: ' + databaseSaveResult.getId();
            }
            else
            {
                wrapper.success = '0';
                for (Database.Error error: databaseSaveResult.getErrors())
                {
                    wrapper.message = 'updation failed with id: ' + databaseSaveResult.getId();
                    wrapper.message += '  message: ' + error.getMessage() + 'status code:'  + error.getStatusCode();
                    wrapper.message += '  getFields: ' + error.getFields();

                }
            }
            
            responsewrapperList.add(wrapper);
        }
        system.debug('responsewrapperList: '+ responsewrapperList);
        return responsewrapperList;
    }
    
    @HttpPatch
    global static List<responseWrapper> updateHrRecords()
    {
        List<responseWrapper> responsewrapperList = new List<responseWrapper>();
       restRequest hrContext = restContext.request;
       system.debug('hrContext: ' + hrContext);
      string hrRequestBody =  hrContext.requestBody.toString();
       system.debug('hrRequestBody: ' + hrRequestBody);
      List<Hiring_Manager__c> hrObj = (List<Hiring_Manager__c>)JSON.deserializeStrict(hrRequestBody, List<Hiring_Manager__c>.class);
        system.debug('hrObj: ' + hrObj);
        
        Database.SaveResult[] databaseSaveResults = Database.update(hrObj, false);
        system.debug('databaseSaveResults: ' + databaseSaveResults);
        for(database.SaveResult databaseSaveResult: databaseSaveResults)
        {
            responseWrapper wrapper = new responseWrapper();
            if(databaseSaveResult.isSuccess())
            {
                wrapper.success = '1';
                wrapper.message = 'record updated successfully with id: '+databaseSaveResult.getId();
            }
            else
            {
                wrapper.success = '0';
                for(database.Error error: databaseSaveResult.geterrors())
                {
                    wrapper.message = 'record failed to update with id: ' + databaseSaveResult.getId();
                    wrapper.message += ' messagege: ' + error.getMessage() + ' status code  ' + error.getStatusCode() + ' error sattus code ' + error.statuscode;
                    
                        
                }
            }
            
            responsewrapperList.add(wrapper);
        }
        system.debug('responsewrapperList: ' + responsewrapperList);        
        return responsewrapperList;
        
    }
}