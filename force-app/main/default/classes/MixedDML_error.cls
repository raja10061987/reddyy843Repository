public class MixedDML_error {

     public  void userInsertWithRole() {
      System.debug('dk');
      Profile p = [SELECT Id FROM Profile where  name = 'Identity User'];
      UserRole r = [SELECT Id FROM UserRole where name = 'CEO'];
      // Create new user with a non-null user role ID
     User u = new User(alias = 'sudhakar', email='r.annapureddy@spglobal.com',emailencodingkey='UTF-8', lastname='reddy',
                       languagelocalekey='en_US',localesidkey='en_US', profileid = p.Id, userroleid = r.Id,timezonesidkey='America/Los_Angeles',
                       username='r.annapureddiy@spgloba12776l.com');
         // set up Object inserted
    insert u;
       
         insertNonsetUp();
         }
    @future
    public static void insertNonsetUp(){
         Account actObj = new Account();
         actObj.Name = 'raja';
         actObj.Phone = '13214325';
         insert actObj;
    }
    

}