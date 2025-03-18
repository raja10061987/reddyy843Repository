@restResource(urlMapping='/caseResourceAPI/*')
Global with sharing class CaseAPI 
{   
    // @HTTPPost
    Global static case insertCaseRecords(string status,string priority,string caseOrigin,string type,string caseReason)
    {
        Case caseObj = new Case();
        caseObj.status = status;
        caseObj.priority = priority;
        caseObj.Origin = caseOrigin;
        caseObj.Type = type;
        caseObj.Reason = caseReason;
        insert caseObj;
        system.debug('caseObj: ' + caseObj);
        return caseObj;
        
    }
    
    @HTTPPost
    Global static case  insertCase()
    {
       restRequest caseRequest = restContext.request;
       system.debug('caseRequest: ' + caseRequest);
       string requestBody = caseRequest.requestBody.tostring();
        system.debug('requestBody: ' + requestBody);
        case CaseObj =  (case)JSON.deserialize(requestBody, case.class);
        system.debug('before inserting CaseObj: ' + CaseObj);
        insert CaseObj;
        system.debug('after inserting CaseObj: ' + CaseObj);
        return CaseObj;
        
        
    }

}