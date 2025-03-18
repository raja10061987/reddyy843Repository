public class ShowCases 
{
    public List<Case> caseList {get;set;}
    public ShowCases()
    {
        caseList= new List<Case>();
        caseList = [Select id, casenumber, status, priority, origin, reason, type, subject,createdby.id from Case Order by casenumber];
        system.debug('caseList: ' + caseList);
    }

}