public class sampleSourceController 
{

    public String Location { get; set; }
    public String actName { get; set; }
    public string rating {get;set;}
  public pageReference goToTargetPage()
  {
     system.debug('act name: ' + actName );
     system.debug('Location: ' + location);
    PageReference pgRef = new PageReference('/apex/sampleTargetPage?actName='+ actName + '&Location=' + Location + '&Rating=' + Rating);
    return pgRef.setRedirect(true);
  }
}