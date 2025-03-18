public class AccountsPaginationController1 
{
    public ApexPages.StandardSetController controller1 {
        get{
            if(controller1 == null)
            {
                controller1 = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [select id,name,phone,fax,industry,rating,Active__c from account]));
            }
            return controller1;
        }
        set;
    }
    public List<Account> getAccounts1()
    {
        List<Account> actList = new List<Account>();
      controller1.setPageSize(5);
        actList= (List<Account>)controller1.getRecords();
        system.debug('actList: ' + actList);
      return   (List<Account>)controller1.getRecords();      
    }

}