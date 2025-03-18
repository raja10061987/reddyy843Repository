public class caerecordStatus 
{
    
    public static void caseRecords()
    {
        List<case> clsoedCaseList = new List<Case>();
        List<case> caseList = [SELECT Id, Type, Status FROM Case where status='New' limit 1];
        if(!caseList.isEmpty())
        {
            for(Case caseObj: caseList)
            {
                caseObj.Status = 'Closed';
                system.debug('caseList: ' + caseList);
               // clsoedCaseList.add(caseObj);
                
            }
            update caseList;
        }
       
       
    }

}