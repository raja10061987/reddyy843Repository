@istest
public class MixedErrorTest 
{
    static testMethod void test_mixed_dmlbug() {  
    User userRecord;
    Account accountRecord;      
    User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        system.debug('this user: ' + thisUser);
    System.runAs ( thisUser ) {
        Profile p = [select id from profile where name='Standard User'];
         UserRole r = [Select id from userrole where name='CEO'];
        userRecord = new User(alias = 'standt', email='standarduser1333323@testorg.com', 
            emailencodingkey='UTF-8', lastname='Testing', 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
            timezonesidkey='America/Los_Angeles', 
            username='reddyykjnkbj@gmail.com');
        insert userRecord;
        accountRecord = new Account(name='s&p global pvt.ltd',rating='Hot');
        insert accountRecord;
    }
    System.runAs(userRecord) {
        test.startTest();
       MixedError.DoDMLOperation(userRecord.Username,accountRecord.Name);
        test.stopTest();
    }

}
}