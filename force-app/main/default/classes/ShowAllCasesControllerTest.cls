@isTest
public class ShowAllCasesControllerTest {

    public static testMethod void getCaseRecordsTest()
    {
        Case caseObj = new Case();
        caseObj.Type = 'Mechanical';
        caseObj.Status = 'New';
        caseObj.Reason = 'Other';
        caseObj.Origin = 'Phone';
        caseObj.Subject = 'this is new case';
        caseObj.Priority = 'Medium';
        insert caseObj;
         system.debug('caseObj: ' + caseObj);
        test.startTest();
        ShowAllCasesController obj = new ShowAllCasesController();
        obj.getCaseRecords();
        test.stopTest();
    }
}