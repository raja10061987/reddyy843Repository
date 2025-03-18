public with sharing class UserHandler {
   
    public static void afterCreateUserAssignPermissionSetandAddIngroup(List<User> userList)
    {
        system.debug('userList: ' + userList); // (User:{Id=0055,Name=Apex Hours},User:{Id=00559,Name=development User})
        List<PermissionSetAssignment> permissinsetList = new List<PermissionSetAssignment>();
        List<GroupMember> groupMemberList = new List<GroupMember>();
        
        permissionSet permissionsetObj1 = [select Id,Name,Label from PermissionSet where Name='flowSeries' WITH SECURITY_ENFORCED limit 1];
         system.debug('permissionsetObj: ' + permissionsetObj1); // permissionSet: {Id=0232cn,Name=flowSeries, Label=flowSeries}
         Group publicGroupObj = [select Id, Name,Type from Group  where Name='flowSeries' and Type='Regular' WITH SECURITY_ENFORCED limit 1];
         system.debug('publicGroupObj: ' +  publicGroupObj); // Group: {Id=0121sa,Name=flowSeries, Type=Regular}

         if(permissionsetObj1 != null)
         {
          for(user userObj: userList)
          {
            if(userObj.IsActive)
            {

            PermissionSetAssignment permissionsetObj = new PermissionSetAssignment();
          permissionsetObj.PermissionSetId = permissionsetObj1.Id;
          permissionsetObj.AssigneeId = userObj.Id;
          permissinsetList.add(permissionsetObj);
            }
          }
          system.debug('permissinsetList: ' + permissinsetList); // (PermissionSetAssignment: {PermissionSetId=07656,AssigneeId=00553})
          insert as user permissinsetList;

         }
         else {
          system.debug('permission set not found');
         }

         if(publicGroupObj != null)
         {
          for(User userObj:userList)
          {
            if(userObj.IsActive)
            {
          GroupMember groupObj = new GroupMember();
          groupObj.GroupId = publicGroupObj.Id;
          groupObj.UserOrGroupId = userObj.Id;
          groupMemberList.add(groupObj);


            }
          
          }
          system.debug('groupMemberList: ' + groupMemberList); // (Group: {GroupId=009787,UserOrGroupId=0867}) 
          insert as user groupMemberList;
          

         }
         else
         {
          system.debug('group member not found');
         }




    }
}