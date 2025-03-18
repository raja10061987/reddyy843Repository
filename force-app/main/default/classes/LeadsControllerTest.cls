@isTest
public with sharing class LeadsControllerTest 
{
   
    @TestSetup
    static void makeData(){
         List<Lead> leadList = new List<Lead>();
         for(integer i=0; i <=10;i++)
         {
            Lead leadObj = new Lead();
            leadObj.LastName = 'test - ' + i;
            leadObj.Company = 'IT - ' + i;
            leadObj.Phone = '8309351867';
            leadObj.Email = 'aa@gmail.com';
            leadList.add(leadObj);
         }
        system.debug('leadList: ' + leadList);
        insert leadList; // ({LastName= test-1,Comapny=IT},{})
    }

    @isTest
    public static void retriveLeadsTest()
    {
        test.startTest();
       Map<String,Integer> returnedLeadsMap = LeadsController.retriveLeads();


        test.stopTest();
    }
}