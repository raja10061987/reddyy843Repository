public with sharing class ExtensionController1 
{
    public List<Account> actRecords {get;set;}
    public ExtensionController1(ApexPages.StandardController controller) 
    {
         actRecords = new List<Account>();
         actRecords = [select Id,Name, Rating, Phone, Industry, AnnualRevenue,Budget__c from Account  WITH SECURITY_ENFORCED];
        system.debug('actRecords: ' + actRecords); // (Account: {id=001wkd,Name= pavan}, Account: {id=001sna,Name=suman} )
        system.debug('actRecords size: ' + actRecords.size());



    }
}