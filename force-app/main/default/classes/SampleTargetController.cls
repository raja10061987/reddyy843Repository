public with sharing class SampleTargetController
{

   public String Location { get; set; }
   public string actName{get;set;}
   public string Rating {get;set;}
   public SampleTargetController()
   {
   Map<string,string>  parameterList = ApexPages.currentPage().getParameters();
   system.debug('parameterList: ' + parameterList);
   actName = ApexPages.currentPage().getParameters().get('actName');
   system.debug('actName: ' + actName);
   Location = Apexpages.currentPage().getParameters().get('Location');
   system.debug('location: ' + location);
   Rating = ApexPages.currentPage().getParameters().get('Rating');
   }
   public pageReference goToSourcePage()
   {
      pageReference pgRef = new PageReference('/apex/sampleSourcePage');
      return pgRef.setRedirect(true);
   }
   
}