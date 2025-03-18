@isTest
public class MixedClassTest 
{
    
    
    public static testMethod void inserUserAccountTest()
    {
       
        User myUser = [select Id,UserName from User where Id=:userInfo.getUserId()];
        Profile proObj = [SELECT Id,Name FROM Profile  WHERE Name='Standard User' WITH SECURITY_ENFORCED];
        UserRole role = [select Id,Name from userRole  where Name='CFO_ManagerUser'  WITH SECURITY_ENFORCED];
        
        
         Account actObj = new Account();
        actObj.Name= 'sumanAccount';
        insert actObj;
        system.debug('actObj testSetUp: ' + actObj);
        MixedDMLClass.mixedDMLMethod();
       
      
    }

}