public with sharing class PickListHelper {
    public PickListHelper() {

    }

    @AuraEnabled(cacheable = true)
    public static Map<String,String> getProfiles()
    {
      Map<String,String> profileMap = new Map<String,String>();
      for(Profile profileObj: [select Id,Name from Profile limit 10])
      {
         profileMap.put(profileObj.Id,profileObj.Name);
      }
      System.debug('profileMap: ' + profileMap); // {001dksnc= admin,001kscs=sales,009=market}
      return profileMap;
    }
}