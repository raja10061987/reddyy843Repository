public with sharing class SortUtil implements Comparable
{
    public enum SortOrder {ASCENDING,DESCENDING}
    public enum Type {TYPE_INTEGER,TYPE_STRING,TYPE_DECIMAL}
    sObject record;
    SortOrder sortOrderValue;
    Type valueType;
    String fieldName;
    public SortUtil(sObject record,SortOrder sortOrderValue,string fieldName,Type valueType) 
    {
      this.record = record; // (Account:{name=peeri,AnnualRevenuue=10000,totalNumberOfEmployees = 3,id=kzjchk})
      this.sortOrderValue = sortOrderValue; // Ascending
      this.fieldName = fieldName; // AnnualRevenuue
      this.valueType = valueType; // TYPE_INTEGER
    }

    public integer compareTo(Object anotherObject)
    {
      sObject secodObject = ((SortUtil)anotherObject).record;
     if(valueType.equals(Type.TYPE_INTEGER))
     {
      return comapareIntegers((Integer)record.get(fieldName),(Integer)secodObject.get(fieldName)); // 10000,5000
     }
     else if(valueType.equals(Type.TYPE_STRING))
     {
      return comapareStrings((String)record.get(fieldName), (String)secodObject.get(fieldName));
     }
     else if(valueType.equals(Type.TYPE_DECIMAL))
     {
      return compareDecimals((Decimal)record.get(fieldName), (Decimal)secodObject.get(fieldName));
     }
     return -1;


    }

    public integer compareDecimals(Decimal sourceValue,Decimal destinationValue)
    {
      if (sortOrderValue.equals(SortOrder.ASCENDING))
      {  // ascending
        System.debug('inside if bloc Decimal:');
        if (sourceValue < destinationValue)
        {
            return -1;
        }
        else if (sourceValue > destinationValue)
        {
           return 1;
        }
        else 
        {
            return 0;
        }

      }
      else
      {  // descending
      System.debug('inside else block decimal: Descending');
        if (sourceValue < destinationValue)
        {
          return 1;
        }
        else if(sourceValue > destinationValue)
        {
           return -1;
        }
        else {
          return 0;
        }
      }

    }

    public integer comapareIntegers(integer sourceValue,integer destinationValue)
    {
      if(sortOrderValue.equals(SortOrder.ASCENDING))
      {
        System.debug('if block called:integer -- asending');
        if (sourceValue < destinationValue)
        {  
          return -1;
        }
        else if (sourceValue == destinationValue)
        {
           return 0;
        }
        else 
        { 
         return 1;
        }        
      }
      else 
      {
        System.debug('inside else blok:integer.. descnding');
            if (sourceValue < destinationValue)
            {
                return 1;
            }
            else if(sourceValue == destinationValue)
            {
                return 0;
            }
            else {
              return -1;
            }
      }    
    }
    public integer comapareStrings(String sourceValue,String destinationValue)
    {
      if(sortOrderValue.equals(SortOrder.ASCENDING))
      {
        System.debug('if block called:string -- asending');
        if (sourceValue < destinationValue)
        {  
          return -1;
        }
        else if (sourceValue.equals(destinationValue))
        {
           return 0;
        }
        else 
        { 
         return 1;
        }        
      }
      else 
      {
        System.debug('inside else blokstring.. descnding');
            if (sourceValue > destinationValue)
            {
                return -1;
            }
            else if(sourceValue.equals(destinationValue))
            {
                return 0;
            }
            else {
              return 1;
            }
      }    
    }

    public static void sortRecords(List<SObject> records, SortOrder sortOrderValue, String fieldName, Type valueType)
    {
     List<SortUtil> sortUtils = new List<SortUtil>();
     
      for(sObject record:records)
      {
        sortUtils.add(new SortUtil(record,sortOrderValue,fieldName,valueType)); // record,ASCENDING,NumberOfEmployees,TYPE_INTEGER
      }
  
      // (SortUtil:[fieldName=NumberOfEmployees,sortOrderValue=asecnding,valueType=TYPE_INTEGER,record=Account:{Name=pioy,NumberOf=50,Annual=89000},],[],[])
     // System.debug('before sorting: ' + sortUtils);
      sortUtils.sort();
     // System.debug('after sorting: ' + sortUtils);
      records.clear();
      for(SortUtil sortUtil: sortUtils)
      {
        records.add(sortUtil.record);
      }
     // System.debug('after sorting accounts:NumberOfEmployees ' + records);




    }
}