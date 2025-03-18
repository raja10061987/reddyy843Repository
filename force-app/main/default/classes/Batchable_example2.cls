// retrive all the accounts and update the rating to hot
Global class Batchable_example2  implements Database.Batchable<sObject>,Database.stateFul,Database.allowsCallouts
{
    Global integer size= 0; // instance variable
    global static integer count = 0; // static variable
    
    Global Database.QueryLocator start(Database.BatchableContext bc){
        string query = 'select id,name,rating from Account';// 55
        return database.getQueryLocator(query); // batch size 10
    }
    // batch1 batch2 batch3 batch4 batch5 batch6
    // 1-10    11-20  21-30  31-40  41-50   51-55
    // 10        10     10     10    10      5   == 55
    // execute(scope) execute(scope) execute(scope) execute(scope) execute(scope) execute(scope)
    //  1                 1                  1            1             1               == 6
    global void Execute(Database.BatchableContext bc, List<Account> scope){
        for(Account actobj: scope){
            size = size + 1;
            count = count + 1;
        }
       
        
    }
    
    global void finish(Database.BatchableContext bc){
       Account actObj = new Account();
        actObj.Name = 'batch call8';
        actObj.Description = 'size: ' + size + '  count: ' + count;
        insert actObj;
    }

}