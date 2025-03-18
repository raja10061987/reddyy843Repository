@isTest
public class AutoLeadConversionAfterUpdateTest 
{
     public static testMethod void LeadConversionAfterUpdateTest()
     {
         List<lead> leadList = new List<lead>();
         for(integer counter = 1; counter<=5;counter++)
         {
         Lead ldObj = new Lead();
         ldObj.Salutation = 'Mr';
         ldObj.FirstName = 'jaggu ' + counter;
         ldObj.LastName = 'Reddy';
         ldObj.Company = 'infosys';
         ldObj.Phone = '8977950912';
         ldObj.MobilePhone = '040999999';
         ldObj.Email = 'reddyy843@gmail.com';
         ldObj.Status = 'Open - Not Contacted';
         ldObj.Rating = 'Hot';
         ldObj.LeadSource = 'Web';
         ldObj.Industry = 'Environmental';
         ldObj.AnnualRevenue = 890000;
         ldObj.Budget__c = 340000;
         ldObj.Do_Not_Create_Opportunity__c = false;
         ldObj.City = 'Hyderabad';
         ldObj.Street = 'patancheruvu';
         ldObj.State = 'telangana';
         ldObj.PostalCode = '523368';
         ldObj.Country = 'India';
         leadList.add(ldObj);
         }
         Account actObj = new Account();
         actObj.Name = 'raja1account';
         actObj.Rating = 'Hot';
         
         insert actObj;
         
        
         insert leadList;
         for(Lead ld:leadList)
         {
             ld.status = 'Closed - Converted';
             
         }
         update leadList;
     } 
}