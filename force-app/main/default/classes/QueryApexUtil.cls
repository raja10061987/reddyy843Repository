public with sharing class QueryApexUtil extends VisualEditor.DynamicPickList
{
    @AuraEnabled
    public static List<SObject> retriveData(string sObjectName)
    {
        String string1 = 'select ID,Name from ';
        String string2 = String.escapeSingleQuotes(sObjectName);
        String string3 = ' limit 100';
        string query = String.escapeSingleQuotes(string1) +sObjectName + String.escapeSingleQuotes(string3);
       List<SObject> sObjectList = Database.query(query);
       System.debug('sObjectList: ' + sObjectList); // (Account:{Id=jashdsa,Name=pavan},Account:{Id=001mxnc,name=suman})
       return sObjectList;

    }
    public override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('account', 'account');
        return defaultValue;
    }
    public override VisualEditor.DynamicPickListRows getValues()
    {
        VisualEditor.DynamicPickListRows pickListRowsList = new VisualEditor.DynamicPickListRows();
        List<VisualEditor.DataRow> dataRowList = new List<VisualEditor.DataRow>();
       List<Schema.SObjectType> sObjectList =  Schema.getGlobalDescribe().values(); // {account=Account,contact = Contact}
      // System.debug('sObjectList: ' + sObjectList); // (Account,Contact)

       for(Schema.SObjectType sObjectTypeName: sObjectList)
       {
       // System.debug('sObjectTypeName: ' + sObjectTypeName.getDescribe());
        VisualEditor.DataRow rowObj = new VisualEditor.DataRow(sObjectTypeName.getDescribe().getLabel(),sObjectTypeName.getDescribe().getName());
        dataRowList.add(rowObj);

       }
      //  System.debug('dataRowList: ' + dataRowList);
       pickListRowsList.addAllRows(dataRowList);
      // System.debug('pickListRowsList: ' + pickListRowsList);
        return pickListRowsList;

    }




   
}