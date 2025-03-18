public class AccountsPaginationController 
{
    public ApexPages.StandardSetController controller {
        get{
            if(controller == null)
            {
                controller = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [select id,name,phone,fax,industry,rating,Active__c from account]));
            }
            return controller;
        }
        set;
    }
    public List<Account> getAccounts()
    {
        List<Account> actList = new List<Account>();
      controller.setPageSize(5);
        actList= (List<Account>)controller.getRecords();
        system.debug('actList: ' + actList);
      return   (List<Account>)controller.getRecords();      
    }

}