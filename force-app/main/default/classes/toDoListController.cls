public with sharing class toDoListController {
    public toDoListController() {
        System.debug('constructor method called');
    }

    @AuraEnabled(cacheable=true)
    public static List<task> getTasks(){
        system.debug('getTasks Method called');
        try {
            return [select subject,OwnerId from task where ownerId =: UserInfo.getUserId() and subject != '' order by subject];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static Task insertTask(string subject){
        try {
            System.debug('insertTask method called');
            Task taskObj = new Task();
             taskObj.Subject = subject;
             taskObj.Status = 'Not Started';
             taskObj.Priority = 'High';
            taskObj.OwnerId = UserInfo.getUserId();
            taskObj.Description	= 'this task is created through LWC component';
            insert taskObj;
            return taskObj;

        } catch (Exception e) {
               system.debug('excepetion occured while inserting record: ' + e.getMessage());
        }
        return null;
    }

    @AuraEnabled
    public static boolean deleteTask(Id recordId){
        try {
            System.debug('delete Task method called');
            system.debug('recordIdtoBeDelete: ' + recordId);
            Database.delete(recordId);
            return true;
        } catch (Exception e) {
            System.debug('exception occured while deleting: ' + e.getMessage());
        }
        return false;
    }
}