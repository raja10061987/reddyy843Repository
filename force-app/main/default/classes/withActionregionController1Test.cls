@IsTest
public class withActionregionController1Test {

    public static testMethod void prioritychangedTest()
    {
        // insert account records
        Account actObj = new Account();
        actObj.Name = 'pavan';
        actObj.Rating = 'Hot';
        actObj.AnnualRevenue = 4000;
        actObj.Active__c = 'Yes';
        actObj.CustomerPriority__c = 'High';
        insert actObj;
         Account actObj1 = new Account();
        actObj1.Name = 'pavan';
        actObj1.Rating = 'Hot';
        actObj1.AnnualRevenue = 4000;
        actObj1.Active__c = 'Yes';
        actObj1.CustomerPriority__c = 'Low';
        insert actObj1;
        
        test.startTest();
        withActionregionController1 obj = new withActionregionController1();
        obj.act = actObj;
        obj.prioritychanged();
        obj.act = actObj1;
        obj.prioritychanged();
        
        test.stopTest();
    }
}