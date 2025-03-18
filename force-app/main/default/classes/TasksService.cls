public with sharing class TasksService 
{
    
    List<Task> tasksList = new List<Task>();
    public void createTasks(List<Opportunity> closedoptLst)
    {
        System.debug('createTasks called');

        for(Opportunity closedOpp: closedoptLst)
        {
            Task taskObj = new Task();
            taskObj.WhatId = closedOpp.Id;
            taskObj.Subject = 'Follow up Task';
            taskObj.ActivityDate = Date.today();
            taskObj.OwnerId = closedOpp.OwnerId;
            taskObj.Status = 'In Progress';
            tasksList.add(taskObj);

        }
        if(tasksList.size() > 0)
        {
        
            DataBase.saveResult[] result = DataBase.Insert(tasksList,true);
            system.debug('result: ' + result);

        }

    }
    
}