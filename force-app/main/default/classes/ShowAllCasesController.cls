public class ShowAllCasesController 
{
    public transient List<Case>  caseRecords{get;set;}
    public  ShowAllCasesController()
   {
     caseRecords = new List<Case>();
     
   }
   
   public void getCaseRecords()
   {
     caseRecords = [SELECT  Id,Type, Status, Reason, Origin, Subject, Priority, Description,CaseNumber FROM Case];
     system.debug('caseRecords: ' + caseRecords); 
   }
}