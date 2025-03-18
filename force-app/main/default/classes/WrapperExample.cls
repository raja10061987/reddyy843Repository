public with sharing class WrapperExample 
{
    public List<AccountWrapper> wrapperList {get;set;}
    public List<AccountWrapper> selectedWrapperList {get;set;}

    public WrapperExample() 
    {
           wrapperList = new List<AccountWrapper>();
           selectedWrapperList = new List<AccountWrapper>();
           AccountWrapper wrapObj1 = new AccountWrapper();
           wrapObj1.actName = 'test-1';
           wrapObj1.actPhone = '8309351867';
           wrapObj1.actRating = 'Hot';
           wrapObj1.isChecked = false;
           wrapperList.add(wrapObj1);

           AccountWrapper wrapObj2 = new AccountWrapper();
           wrapObj2.actName = 'test-2';
           wrapObj2.actPhone = '7013948962';
           wrapObj2.actRating = 'Warm';
           wrapObj2.isChecked = false;
           wrapperList.add(wrapObj2);

           for(Account actObj: [select Id,Name,Phone,Rating from Account limit 10])
           { 
            AccountWrapper wrapperObj = new AccountWrapper();
            wrapperObj.ActName =actObj.Name;
            wrapperObj.ActPhone = actObj.Phone;
            wrapperObj.actRating = actObj.Rating;
            wrapperObj.isChecked = false;
            wrapperList.add(wrapperObj);
             
           }
        
           System.debug('wrapperList: ' + wrapperList); // (AccountWrapper: [actName=test-1,actPhone=999],AccountWrapper: [actname=test-2,actPhone=9888])

    }

    public void displaySelectedRecords()
    {
        selectedWrapperList = new List<AccountWrapper>();
        for(AccountWrapper wrapObj: wrapperList)
        {
           if(wrapObj.isChecked)
           {
               selectedWrapperList.add(wrapObj);  
           }
        }
        System.debug('selectedWrapperList: ' + selectedWrapperList);

    }

    public class AccountWrapper
    {
        public boolean isChecked {get;set;}
        public string ActName {get;set;}
        public String ActPhone {get;set;}
        public String actRating {get;set;}
    }
}