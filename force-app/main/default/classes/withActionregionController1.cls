public class withActionregionController1 
{
    public Account act {get;set;}
    public boolean showPhone {get;set;}
   public withActionregionController1()
   {
       act = new Account();
       this.showPhone = false;
       
   }
    public void prioritychanged()
    {
        if(act.customerpriority__c == 'High')
        {
            this.showPhone = true;
            system.debug('high priority');
            system.debug('showPhone: ' + showPhone);
        }
        else
        {
            this.showPhone = false;
            system.debug('low priority');
            system.debug('showPhone: ' + showPhone);
        }
        
    }
}