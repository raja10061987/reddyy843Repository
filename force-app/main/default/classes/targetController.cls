public with sharing class targetController 
{
  public pageReference gotoTargetPage()
  {
    pageReference pgRef = new PageReference('/apex/SourceVFPage');
      return pgRef.SetRedirect(true);
  }
}