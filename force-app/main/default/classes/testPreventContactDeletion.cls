@isTest
private class testPreventContactDeletion {
  @testsetUp static void testsetUp(){
        Contact conObj = new Contact();
       conObj.FirstName = 'Raja';
       conObj.LastName = 'reddy';
       conObj.LeadSource = 'Web';
       conObj.IsPrimary__c = true;
       insert conObj;
    }
    
    private static testMethod void testcreateCase(){
        Contact conObj = [select Id,LeadSource from Contact];
        test.startTest();
        conObj.LeadSource = 'Other';
        update conObj;
        test.stopTest();
        Case caseObj = [select Id from Case where contactId =: conObj.Id];
        system.assert(caseobj.Id != null);
        
    }
    private static testMethod void testprimaryContactDeletion(){
        Contact conObj = [select Id,isPrimary__c from Contact limit 1];
        test.startTest();
        Database.DeleteResult result = Database.delete(conObj.Id, false);
        test.stopTest();
        system.assertEquals('you cannot delete primary contacts', result.getErrors()[0].getMessage());
    }
               

}