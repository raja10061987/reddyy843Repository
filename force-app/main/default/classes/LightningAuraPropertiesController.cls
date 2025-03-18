public with sharing class LightningAuraPropertiesController 
{
    @AuraEnabled
    public string name {get;set;}
    @AuraEnabled
    public string srNumber {get;set;}
    @AuraEnabled
    public string industry {get;set;}
    @AuraEnabled
   public string companyName {get;set;}

   @AuraEnabled
   public List<Account> actList {get;set;}
   

   @AuraEnabled
   public static LightningAuraPropertiesController getDetails()
   {
    LightningAuraPropertiesController obj = new LightningAuraPropertiesController();
    obj.actList = new List<Account>();
    for(Account actObj: [select id,Name, Rating, Phone, Website from account WITH SECURITY_ENFORCED limit 5])
    {
        obj.actList.add(actObj);
    }
    obj.name = 'Rajasekhar';
    obj.srNumber = '7013948962';
    obj.industry = 'IT';
    obj.companyName = 'infosys';
    return obj; // LightningAuraPropertiesController: [name=rajasekhar,srNumber=7013948962,industry=IT,companyName=infosys]
    // LightningAuraPropertiesController: [actList:(Account:{id=jkasha,name=raja},Account:{id=jasa,name=pavan}),name=raja]
   }

}