public with sharing class MixedClass 
{

    public static void inserUserAccount()
    {
 
        Account actObj = new Account();
        actObj.Name='apexHours10';
        insert as user actObj;
        system.debug('actObj: ' + actObj);
        List<String> actIdsSet = new List<String>();
           List<Account> actList = [select Id,Name from Account WITH SECURITY_ENFORCED limit 10];
           system.debug('actList: ' + actList); // (00373622,001acba)

           for(Account actObj1: actList)
           {
            actIdsSet.add(actObj1.Id);
           }

        MixedDMLClass.mixedDMLMethod();



    }
   
}