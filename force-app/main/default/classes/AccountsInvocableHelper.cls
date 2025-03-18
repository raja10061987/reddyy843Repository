public with sharing class AccountsInvocableHelper {
    
    @InvocableMethod(label = 'Create Account and case' description= 'this will create account and related case')
    public static void createAccountRelatedCase() 
    {

        // create account record

        Account actObj = new Account();
        actObj.Name = 'raja1';
        actObj.Phone = '8309351867';
        actObj.Rating = 'Hot';
        actObj.Industry = 'Banking';
        insert actObj; // {Id=001xmn,Name=raja1,Phone=8309351867,Rating=Hot,Industry=Banking}
         System.debug('inserted actObj: ' + actObj);
        // create case record, related to account

        Case caseObj = new Case();
        caseObj.Status = 'Working';
        caseObj.Priority = 'Medium';
        caseObj.Origin = 'Phone';
        caseObj.Type = 'Mechanical';
        caseObj.Comments = 'Case is created through apex class by invoking process builder';
        caseObj.accountId = actObj.Id;

        insert caseObj; // {Id=003nsbc,accountId = 001jchbz,status=working,Priority=Medium,Origin=Phone}
        system.debug('inserted caseobj: ' + caseObj);



    }
}