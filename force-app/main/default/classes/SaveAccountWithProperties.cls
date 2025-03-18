public with sharing class SaveAccountWithProperties {
    public string actName {get;set;}
    public string actRating {get;set;}
    public string actPhone {get;set;}

    public pageReference addAccount()
    {
        Account actObj = new Account();
        actObj.Name = actName;
        actObj.Rating = actRating;
        actObj.Phone = actPhone;
        insert actObj; // Account: {Name=pavan,Rating=Hot,Phone=122,Id=001jcdbhasjhbc}
        System.debug('actObj: ' + actObj);
        return new pageReference('/' + actObj.Id);

    }


}