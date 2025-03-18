public with sharing class mySortUtil implements Comparable
{
    public mySortUtil() {

    }

    public enum SortOrder{ASCENDING,DESCENDING}
    public enum Type {TYPE_INTEGER,TYPE_DECIMAL,TYPE_STRING}
    sObject record;
    SortOrder sortOrderValue;
    Type typeValue;
    string fieldName;
    public mySortUtil(sObject record,SortOrder sortOrderValue, string fieldName,Type typeValue)
    {
     this.record = record;
     this.sortOrderValue = sortOrderValue;
     this.fieldName = fieldName;
     this.typeValue = typeValue;
    }
    public integer compareTo(Object anotherObject)
    {
       sObject secondObject = ((mySortUtil)anotherObject).record;
       if (typeValue.equals(Type.TYPE_INTEGER))
       {
          return compareIntegers((Integer)record.get(fieldName), (Integer)secondObject.get(fieldName));
       }
       else if(typeValue.equals(Type.TYPE_DECIMAL))
       {
        return compareDecimals((Decimal)record.get(fieldName), (Decimal)secondObject.get(fieldName));
       }
       else if(typeValue.equals(Type.TYPE_STRING))
       {
        return compareStrings((String)record.get(fieldName),(String)secondObject.get(fieldName));
       }
       return -1;


    }

    public integer compareStrings(String sourceValue,String destinationValue)
    {
       if(sortOrderValue.equals(SortOrder.ASCENDING))
       {
        System.debug('String comparison: ascending');
        if (sourceValue < destinationValue)
        {
           return -1;
        }
        else if(sourceValue > destinationValue)
        {
         return 1;
        }
        else 
        {
         return 0;
        }
       }
       else 
       {
        System.debug('String comparison: Descending');
        if (sourceValue > destinationValue)
        {
           return -1;
        }
        else if(sourceValue < destinationValue)
        {
         return 1;
        }
        else 
        {
         return 0;
        }

       }
    }

    public integer compareDecimals(Decimal sourceValue,Decimal destinationValue)
    {
            if(sortOrderValue.equals(SortOrder.ASCENDING))
            {
                System.debug('Decimal comparison: ascending');
               if(sourceValue < destinationValue)
               {
                  return -1;
               }
               else if (sourceValue > destinationValue)
               {
                return 1;
               }
               else {
                return 0;
               }
            }
            else 
            {
                System.debug('Decimal comparison: descending');
                if(sourceValue > destinationValue)
               {
                  return -1;
               }
               else if (sourceValue < destinationValue)
               {
                return 1;
               }
               else {
                return 0;
               }
            }
    }

    public integer compareIntegers(integer sourceValue,integer destinationValue)
    {
            if(sortOrderValue.equals(SortOrder.ASCENDING))
            {
                System.debug('integer comparison: ascending');
               if(sourceValue < destinationValue)
               {
                  return -1;
               }
               else if (sourceValue > destinationValue)
               {
                return 1;
               }
               else {
                return 0;
               }
            }
            else 
            {
                System.debug('integer comparison: descending');
                if(sourceValue > destinationValue)
               {
                  return -1;
               }
               else if (sourceValue < destinationValue)
               {
                return 1;
               }
               else {
                return 0;
               }
            }
    }


    public static void sortOrder(List<SObject> records, SortOrder sortOrderValue,string fieldName, Type typeValue)
    {
       List<mySortUtil> mySorUtilList = new List<mySortUtil>();
       for(sObject record:records)
       {
      mySorUtilList.add(new mySortUtil(record, sortOrderValue, fieldName, typeValue));
       }
       mySorUtilList.sort();
       records.clear();
       for(mySortUtil mysortUtil: mySorUtilList)
       {
         records.add(mysortUtil.record);
       }
    }
}