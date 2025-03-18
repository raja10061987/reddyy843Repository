public class withActionregionController 
{
    public account acc {get;set;}
    public boolean showPhone {get;set;}
    
    public withActionregionController()
    {
        system.debug('pageloaded....');
     acc = new Account();
     showPhone = false;
    }
    public void priorityChanged()
    {
        system.debug('priority changed');
        if(acc.CustomerPriority__c == 'High')
        {
            system.debug('customer having higest priority');
            showPhone = true;
        }
        else
        {
             system.debug('customer having not higest priority'); 
            showPhone = false;
        }
       // return null;
    }
}