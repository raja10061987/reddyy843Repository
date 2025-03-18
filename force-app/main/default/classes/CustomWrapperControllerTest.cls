@isTest
public class CustomWrapperControllerTest {
   public static testMethod void  getDataTest()
   {
       Account actObj = new Account();
       actObj.Name = 'pavan reddy';
       actObj.Rating = 'Hot';
       insert actObj;
       // inserted 5 lead records
       List<Lead> leadList = new List<Lead>();  
       for(integer i = 1; i <=5;i++)
       {
        Lead lObj = new Lead();
       lObj.FirstName = 'ravi - ' + i;
       lObj.LastName = 'reddy - ' + i;
       lObj.Company = 'infosys';
       lObj.Status = 'Open-Not contacted';
       lObj.Email = 'a@gmail.com';
       lObj.Phone = '8309351867';
       lObj.Fax = '88888';
       lObj.IsConverted = false;
       leadList.add(lObj);
       }
       system.debug('leadList: ' + leadList);
       if(!leadList.isEmpty())
       {
           insert leadList;
       }
       
       // inserted 5 contact records
       List<contact> contList = new List<contact>();
       for(integer i = 0; i <=5; i++)
       {
           Contact conObj = new contact();
           conObj.FirstName = 'pavan- ' + i;
           conObj.LastName = 'reddy - ' + i;
           conObj.Email = 'b@gmail.com';
           conObj.Phone = '999999';
           conObj.Fax = '888888';
           conObj.AccountId = actObj.Id;
           contList.add(conObj);
       }
       system.debug('contList: ' + contList);
       if(!contList.isEmpty())
       {
           insert contList;
       }
       CustomWrapperController obj = new CustomWrapperController();
       test.startTest();
       obj.getData();
       obj.selectAllRecords();
       obj.deleteselectedRecords();
       obj.deselectAllRecords();
       test.stopTest();
   }
}