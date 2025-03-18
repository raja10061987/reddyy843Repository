Global with sharing class batchableDeleteOpportunities implements DataBase.Batchable<sObject>,schedulable,Database.stateFul,Database.AllowsCallouts {
    Global batchableDeleteOpportunities() {

    }
    Global Database.QueryLocator start(Database.batchableContext bc){
       return Database.getQueryLocator('select Id from Opportunity');
    }
    Global void execute(Database.batchableContext bc, List<sObject> records){
           delete records;
    }
    Global void execute(SchedulableContext sc){
          //
    }
    Global void finish(database.batchableContext bc){
      //  
    }
}

// Execute the batch jobs
// batchableDeleteOpportunities obj = new batchableDeleteOpportunities();
// Id batchId = Database.Execute(obj,1);