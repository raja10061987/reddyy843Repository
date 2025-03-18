public with sharing class SourceController 
{
   public pageReference goToTargetPage()
   {
      PageReference pageRef = new PageReference('/apex/TargetVFPage');
          return pageRef.setRedirect(true);
   } 
}