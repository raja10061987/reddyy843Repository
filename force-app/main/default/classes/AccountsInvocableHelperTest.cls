@isTest
public with sharing class AccountsInvocableHelperTest 
{

    @isTest
    public static void createAccountRelatedCaseTest()
    {
           Test.StartTest();
           AccountsInvocableHelper.createAccountRelatedCase();
           Test.StopTest();
    }
    
}