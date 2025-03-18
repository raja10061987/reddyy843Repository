trigger UserOperations on User (after insert) 
{
    if(trigger.isAfter && trigger.isInsert)
    {
        List<User> userList = trigger.New;
        system.debug('userList: ' + userList);
        UserHandler.afterCreateUserAssignPermissionSetandAddIngroup(userList);

    }

}