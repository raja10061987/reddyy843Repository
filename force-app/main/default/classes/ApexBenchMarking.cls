public with sharing class ApexBenchMarking 
{
    public static void singleAssignment()
    {
        integer startCpuTime;
        integer endCPUTime;
        integer totalTimeTaken;
        Contact contObj = [select Id,Name,AccountId from Contact WITH USER_MODE limit 1];
        Id actId;
        Id sourceId = contObj.AccountId;
        startCpuTime = Limits.getCpuTime();  // 6
        System.debug('startCpuTime: ' + startCpuTime);
        for(integer i = 0; i <=100000;i++)
        {
            actId = sourceId;
        }
        endCPUTime = Limits.getCpuTime();
        System.debug('endCPUTime: ' + endCPUTime); // 143
        totalTimeTaken = endCPUTime - startCpuTime;
        System.debug('totalTimeTaken: ' + totalTimeTaken); // 137


    }

    public static void singleAssignment10Times()
    {
        integer startCpuTime;
        integer endCPUTime;
        integer totalTimeTaken;
        Contact contObj = [select Id,Name,AccountId from Contact WITH USER_MODE limit 1];
        Id actId;
        Id sourceId = contObj.AccountId;
        startCpuTime = Limits.getCpuTime();  // 7
        System.debug('startCpuTime: ' + startCpuTime);
        for(integer i = 0; i <=100000;i++)
        {
            actId = sourceId;
            actId = sourceId;
            actId = sourceId;
            actId = sourceId;
            actId = sourceId;
            actId = sourceId;
            actId = sourceId;
            actId = sourceId;
            actId = sourceId;
            actId = sourceId;
        }
        endCPUTime = Limits.getCpuTime();
        System.debug('endCPUTime: ' + endCPUTime); // 556
        totalTimeTaken = endCPUTime - startCpuTime;
        System.debug('totalTimeTaken: ' + totalTimeTaken); // 549


    }

    public static void dynamicFieldAssignment()
    {
        integer startCpuTime;
        integer endCPUTime;
        integer totalTimeTaken;
        Contact contObj = [select Id,Name,AccountId from Contact WITH USER_MODE limit 1];
        Id actId;
        Id sourceId = contObj.AccountId;
        startCpuTime = Limits.getCpuTime();  // 4
        System.debug('startCpuTime: ' + startCpuTime);
        for(integer i = 0; i <=100000;i++)
        {
             actId = (Id)contObj.get('AccountId');
             actId = (Id)contObj.get('AccountId');
             actId = (Id)contObj.get('AccountId');
             actId = (Id)contObj.get('AccountId');
             actId = (Id)contObj.get('AccountId');
             actId = (Id)contObj.get('AccountId');
             actId = (Id)contObj.get('AccountId');
             actId = (Id)contObj.get('AccountId');
             actId = (Id)contObj.get('AccountId');
             actId = (Id)contObj.get('AccountId');
            // actId = Id.valueOf(String.valueOf(contObj.get('AccountId')));
            // actId = Id.valueOf(String.valueOf(contObj.get('AccountId')));
            // actId = Id.valueOf(String.valueOf(contObj.get('AccountId')));
            // actId = Id.valueOf(String.valueOf(contObj.get('AccountId')));
            // actId = Id.valueOf(String.valueOf(contObj.get('AccountId')));
            // actId = Id.valueOf(String.valueOf(contObj.get('AccountId')));
            // actId = Id.valueOf(String.valueOf(contObj.get('AccountId')));
            // actId = Id.valueOf(String.valueOf(contObj.get('AccountId')));
            // actId = Id.valueOf(String.valueOf(contObj.get('AccountId')));
            // actId = Id.valueOf(String.valueOf(contObj.get('AccountId')));
        }
        endCPUTime = Limits.getCpuTime();
        System.debug('endCPUTime: ' + endCPUTime); // 12209
        totalTimeTaken = endCPUTime - startCpuTime;
        System.debug('totalTimeTaken: ' + totalTimeTaken); // 12205


    }
    public static void doubleMethod()
    { // double 200 times faster than decimal
        Double x = 0.02;
        Double y = 0.03;
        Double total = y - X;
        System.debug(LoggingLevel.Error, 'Double Total: ' + total); // 0.099999999999
    }
    
    public static void decimalMethod()
    {
        Decimal x = 0.02;
        Decimal y = 0.03;
        Decimal total = y - X;
        System.debug(LoggingLevel.Error, 'Double Total: ' + total); // 0.01
    }
}