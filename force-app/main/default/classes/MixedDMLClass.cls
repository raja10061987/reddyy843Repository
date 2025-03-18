public with sharing class MixedDMLClass {
    
    @future
    public static void mixedDMLMethod(List<String> actList)
    {
        system.debug('future method called');
        Profile proObj = [SELECT Id,Name FROM Profile  WHERE Name='Standard User' WITH SECURITY_ENFORCED];
        UserRole role = [select Id,Name from userRole  where Name='CFO_ManagerUser'  WITH SECURITY_ENFORCED];
        User userObj = new User();
        userObj.Alias = 'alias';
        userObj.Email = 'abcd@gmail.com';
        userObj.Emailencodingkey = 'UTF-8';
        userObj.LastName= 'Hours';
        userObj.Languagelocalekey = 'en_US';
        userObj.localesidkey = 'en_US';
        userObj.Timezonesidkey = 'America/Los_Angeles';
        userObj.Username = 'apexHourshello@gmail.com';
        userObj.ProfileId = proObj.Id;
        userObj.Userroleid = role.Id;
        insert as user userObj;
        system.debug('userObj: ' + userObj);
    }
}