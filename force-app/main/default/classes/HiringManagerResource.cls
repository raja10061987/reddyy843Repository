@restResource(urlmapping='/HiringManagerAPI/*')
global with sharing class HiringManagerResource 
{
   
    Global static map<string,string> deleteHRRecord()
    {
        system.debug('inside HR delete record method');
        map<string,string> resourceMap = new map<string,string>();
        restRequest HrContext = restContext.request;
        string  HrURI = HrContext.requestURI; // /HiringManagerAPI/a085g000003w0LS
        Id HrId =  HrURI.substring(HrURI.lastIndexOf('/') + 1); // a085g000003w0LS
        Hiring_Manager__c hrObj = new Hiring_Manager__c(Id =HrId);
        system.debug('hrObj: ' + hrObj);
        try
        {
            delete hrObj;
            resourceMap.put('success','1');
            resourceMap.put('message','record deleted successfully');
        }
        catch(dmlException ex)
        {
            resourceMap.put('success','0');
            resourceMap.put('message', ex.getMessage());
        }
        
        return resourceMap;
    }
    
    global class respnseWrapper
    {
        string message;
        string success;
    }
    
    @HttpDelete
    global static List<respnseWrapper> deleteBulkRecords()
    {
        List<respnseWrapper> responseWrapperList = new List<respnseWrapper>();
        restRequest HrRestrequest = restContext.request;
        system.debug('HrRestrequest: ' + HrRestrequest);
        string hrRequestURI = HrRestrequest.requestURI; // /HiringManagerAPI/a085g000000fwLu,a085g000000f76U,a085g000000f7Ch
        
        integer indexPosition = hrRequestURI.lastIndexOf('/') + 1; // 18
        system.debug('indexPosition: ' + indexPosition);
        Id[] hrIds = hrRequestURI.substring(indexPosition).split(',');
         
         List<Hiring_Manager__c> hrList = new List<Hiring_Manager__c>();
        
          for(Id hrId:hrIds)
          {
              Hiring_Manager__c hrObj = new Hiring_Manager__c();
              hrObj.Id = hrId;
              hrList.add(hrObj);
              system.debug('hrList: ' + hrList);
          }
            
       List<Database.DeleteResult> deleteResults = Database.delete(hrList);
       system.debug('deleteResults: ' + deleteResults);
        
        for(Database.DeleteResult deleteResult: deleteResults)
        {
           system.debug('deleteResult: ' + deleteResult);
            respnseWrapper wrapper = new respnseWrapper();
            if(deleteResult.isSuccess())
            {
                wrapper.success= '1';
                wrapper.message = 'the record deleted success fully: ' + deleteResult.getId();
            }
            else
            {
                 wrapper.success = '0';
                for(Database.Error error: deleteResult.getErrors())
                {
                    wrapper.message = 'the following error has occured with id: ' + deleteResult.getId() +  '<==>';
                    wrapper.message += error.getStatusCode() + ':::' + error.statuscode + '<==>';
                    wrapper.message += 'the error occured because of these fields: ' + error.getFields();
                }
            }
            
            // adding the wrapper to the list
             responseWrapperList.add(wrapper);
           
        }
        
        return responseWrapperList;
          
        
    }

}