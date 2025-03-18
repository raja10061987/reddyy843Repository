@isTest
public with sharing class UserOperationsTest 
{
    

    @isTest
    public static void userHandlerTest()
    {
        Test.startTest();
        Profile profileObj = [select Id,Name from Profile where Name='Standard User' limit 1];
  User userObj = new User();
  userObj.LastName = 'raja';
  userObj.Alias = 'myalias';
  userObj.Email = 'aa@gmail.com';
  userObj.UserName= 'salesforce12131986@gmail.com';
  userObj.CommunityNickname  = 'adminNick8908';
  userObj.ProfileId = profileObj.Id;
  userObj.EmailEncodingKey = 'UTF-8';
  userObj.TimeZoneSidKey = 'America/Los_Angeles';
  userObj.LocaleSidKey = 'en_US';
  userObj.LanguageLocaleKey = 'en_US';
  system.debug('userObj: ' + userObj);
  insert userObj;
  system.assert(userObj.Id != null,'user record not inserted successfuly');
  system.debug('after insert userObj: ' + userObj);

        Test.stopTest();
    }
    
}