public with sharing class PickListUtilController 
{
    @AuraEnabled
    public static Map<String,String> retriveValues()
    {
        Map<String,String> pickListValuesMap = new Map<String,String>();
        try {
            for (Contact conObj : [select Id,Name from Contact WITH SECURITY_ENFORCED Limit 1]) {
                pickListValuesMap.put(conObj.Id, conObj.Name); // {001kasdak=raja,001askjda=pavan}
            }
            System.debug('pickListValuesMap: ' + pickListValuesMap);
            return pickListValuesMap;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
}