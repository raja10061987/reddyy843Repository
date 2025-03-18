public class contacttriggerhandler1 {

    public static void createCase(Map<Id,Contact> contactNewMap,Map<Id,Contact> contactOldMap){
        List<Case> caseList = new List<Case>();
        for(Contact conObj: contactNewMap.values()){
            if(contactNewMap.get(conObj.Id).LeadSource != contactOldMap.get(conObj.Id).LeadSource &&
               contactNewMap.get(conObj.Id).LeadSource == 'Other'){
                Case caseObj = new Case();
                caseObj.Priority = 'High';
                caseObj.Status = 'New';
                caseObj.Origin = 'Phone';
                caseObj.Subject = 'case is created from leadsource to other';
                caseObj.contactId = conObj.Id;
                caseList.add(caseObj);
            }
        }
        if(!caseList.isEmpty()){
            insert caseList;
        }
    }
    
    
}