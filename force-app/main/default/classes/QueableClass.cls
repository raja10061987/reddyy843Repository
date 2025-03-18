public with sharing class QueableClass implements Queueable,Database.allowsCallouts
{
    private String recordId;
    public QueableClass(String recordId) 
    {
        this.recordId = recordId;

    }
    public void execute(QueueableContext qc) 
    {
        Task taskObj = new Task();
        taskObj.Subject = 'Follow up Queable';
        taskObj.ActivityDate = Date.today();
        taskObj.OwnerId = UserInfo.getUserId();
        taskObj.WhatId = recordId;
        insert taskObj;
        system.debug('taskObj: ' + taskObj);

        // calling again queable chain

        QueableClass obj = new QueableClass('0015g00001dxeG1AAI');
        Id quejobId = system.EnqueueJob(obj);
        system.debug('quejobId chain: ' + quejobId);


    
    }
}