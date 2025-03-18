public class HiringManager {
    public static void checkDuplicateRecords(List<Hiring_manager__C> hrList)
    {
         for(Hiring_manager__C hrRecord:hrList)
        {
            //system.debug('hrRecord: ' + hrRecord);
            integer hrRecordsCount = [SELECT count() FROM Hiring_Manager__c 
                                      where name=:hrRecord.Name and Contact_Number__c=:hrRecord.Contact_Number__c];
            // system.debug('hrRecord Count: ' + hrRecordsCount);
            if(hrRecordsCount > 0)
             {
                hrRecord.addError('Duplicate Record found with same Name. Record Not acceptable: ' + hrRecord.Name );
            }
            
        }
    }
    
    public static void AutosyncHiringManagerRecruiter(List<Hiring_manager__c> hrList)
    {
        List<Recruiter__c> recList = new List<Recruiter__C>();
        for(Hiring_manager__C hRObj:hrList)
        {
           // system.debug('hrRecord: ' + hrObj);
            
            Recruiter__c recObj = new Recruiter__c();
            recObj.Name = hrObj.Name;
            recObj.City_Name__c = hrObj.Location__c;
            recObj.Email_Address__c = hrObj.Email_Id__c;
            recObj.Phone_Number__c = hrObj.Contact_Number__c;
            recObj.Designation__c = hrObj.Designation__c;
            recObj.Hiring_Manager_id__c = hrObj.Id;
            recList.add(recObj);
        }
        if(recList.size() > 0)
        {
            insert recList;
        }
        
    }
    
    public static void AutoUpdateHiringManagerRecruiter(List<Hiring_manager__C> hrList,Map<Id,Hiring_manager__C> hrOldmap,Map<Id,Hiring_manager__C> hrNewMap)
    {
       if(triggerGlobalVariable.firstRun)
       {
           triggerGlobalVariable.firstRun = false;
        set<Id> updatedRecordIds = new set<Id>();
        for(Hiring_manager__C hr:hrList)
        {
            if(( hrOldmap.get(hr.id).Name != hr.Name) || (hrOldmap.get(hr.id).Location__C != hr.Location__C) || (hrOldmap.get(hr.id).Email_id__C != hr.Email_id__C) || (hrOldmap.get(hr.id).Designation__c != hr.Designation__c)|| (hrOldmap.get(hr.id).Contact_number__C != hr.Contact_number__C))
            {
               system.debug('inside if block');
               updatedRecordIds.add(hr.Id);
            }
            
        }
        system.debug('updated record Ids: ' + updatedRecordIds);
        // get the child records
        List<Recruiter__c> recurterList = [SELECT Id, Name, City_Name__c, Designation__c, Phone_Number__c, Email_Address__c,Hiring_Manager_id__c 
                 FROM Recruiter__c where Hiring_Manager_id__c=:updatedRecordIds];
        system.debug('recurterList size: ' + recurterList.size());
      //  system.debug('recurterList: ' + recurterList );
        
        if(!recurterList.isEmpty())
        {
            for(Recruiter__c recruiter: recurterList)
            {
                system.debug('recruiter record: ' + recruiter.Hiring_Manager_id__c);
                // get the parent record
                Hiring_manager__C hrRecord = hrNewMap.get(recruiter.Hiring_Manager_id__c);
                recruiter.Name = hrRecord.Name;
                recruiter.City_Name__c = hrRecord.Location__c;
                recruiter.Email_Address__c = hrRecord.Email_Id__c;
                recruiter.Designation__c = hrRecord.Designation__c;
                recruiter.Phone_Number__c = hrRecord.Contact_Number__c;
                
            }
            
            if(!recurterList.isEmpty())
            {
                update recurterList;
            }
        }
       }
          
    }
    
    
    public static void AutoUpdateRecruiterToHiringManager(List<Recruiter__c> NewrecRecords,Map<Id,Recruiter__c> oldRecruiterMap)
    {
        set<Id> updatedRecordIds = new set<Id>();
       for(Recruiter__c NewrecRecord:NewrecRecords)
       {   
           if((oldRecruiterMap.get(NewrecRecord.id).Name != NewrecRecord.Name) || (oldRecruiterMap.get(NewrecRecord.id).City_Name__c != NewrecRecord.City_Name__c) || (oldRecruiterMap.get(NewrecRecord.id).Email_Address__c != NewrecRecord.Email_Address__c) || (oldRecruiterMap.get(NewrecRecord.id).Designation__c != NewrecRecord.Designation__c) || (oldRecruiterMap.get(NewrecRecord.id).Phone_Number__c != NewrecRecord.Phone_Number__c))
           {
             updatedRecordIds.add(NewrecRecord.Hiring_Manager_id__c);     
           }
                      
       }
      // system.debug('updatedRecordIds: ' + updatedRecordIds);
       
       List<Hiring_manager__c> hrRecordList = [SELECT Id, Name, Location__c, Contact_Number__c, Email_Id__c, Designation__c 
                                     FROM Hiring_Manager__c where id=:updatedRecordIds];
      // system.debug('my parent hrRecord: '  + hrRecordList);
       
       for(Recruiter__c NewrecRecord:NewrecRecords)
       {
          // Hiring_manager__c hrRecord = trigger.newMap.get(recRecord.Hiring_Manager_id__c);
           for(Hiring_manager__c hrRecord:hrRecordList )
            {
               hrRecord.Name = NewrecRecord.Name;
               hrRecord.Location__c = NewrecRecord.City_Name__c;
               hrRecord.Email_Id__c = NewrecRecord.Email_Address__c;
               hrRecord.Designation__c = NewrecRecord.Designation__c;
               hrRecord.Contact_Number__c = NewrecRecord.Phone_Number__c;
            }
           
       }
       if(!hrRecordList.isEmpty())
       {
           update hrRecordList;
       }
        
    }
    
    public static void HiringManagerRecordsSharing(List<Hiring_Manager__C> hrList)
    {
        List<Hiring_manager__share> shareList = new List<Hiring_Manager__Share>();
        for(Hiring_manager__c hr:hrList)
        {
            if(hr.Share_Record_To__c != null)
            {
                Hiring_manager__share hrToShare = new Hiring_manager__share();
                hrToShare.ParentId = hr.id;
                hrToShare.UserOrGroupId = hr.Share_Record_To__c;
                hrToshare.AccessLevel = 'EDIT';
                hrToShare.RowCause = Schema.hiring_manager__share.RowCause.Request_By_client__c;
                shareList.add(hrToShare);
            }
        }
        if(!shareList.isEmpty())
        {
            insert shareList;
        }
    }
    
    public static void shareHRRecordsAfterUpdate(List<Hiring_manager__C> newhrList,Map<Id,Hiring_Manager__C> oldMapHrList,Map<Id,Hiring_Manager__C> newHrMapList)
    {
        set<id> removeAccessto = new set<Id>();
        List<Hiring_manager__Share> hrShareList = new List<Hiring_Manager__Share>();
        // record sharing to the specified user
        for(Hiring_Manager__C hr:newhrList)
        {  
            Hiring_manager__Share hrToShare = new Hiring_Manager__Share();
            if(hr.Share_Record_To__c != null && oldMapHrList.get(hr.id).share_record_to__C != newHrMapList.get(hr.id).share_record_to__C)
            {
                removeAccessto.add(oldMapHrList.get(hr.id).share_record_to__C);
            }
           hrToShare.ParentId = hr.id;
           hrToShare.UserOrGroupId = hr.Share_Record_To__c;
           hrToShare.AccessLevel = 'EDIT';
           hrToShare.RowCause = schema.Hiring_Manager__Share.RowCause.Request_By_Client__C;
           hrShareList.add(hrToShare);
        }
        
        if(!removeAccessto.isEmpty())
        {
          List<Hiring_Manager__Share> removeoldUserAccess = [SELECT Id, ParentId, UserOrGroupId, AccessLevel, RowCause  FROM Hiring_Manager__Share  where UserOrGroupId=:removeAccessto and ParentId in: newHrMapList.keyset() and RowCause != 'Owner' ];
                        
             delete removeoldUserAccess;
        }
        if(!hrShareList.isEmpty())
        {
            system.debug('New User Access: ' + hrShareList);
            insert hrShareList;
        }
        
    }
    
    public static void getAzureCredentials(List<Hiring_Manager__c> newHrList)
    {
         for(Hiring_Manager__c HrObj: newHrList)
           {
               if(HrObj.Azure_Name__c != '' && HrObj.Azure_Name__c != null)
               {
               HrObj.End_Point__c = AzureBlobCredentials__c.getInstance(HrObj.Azure_Name__c).endPoint__C;
               }
           }
    }
    
    public static void deleteAllRecuruitersRelatedtoHRRecords(set<Id> oldHrMapIds)
    {
        system.debug('oldHrMapIds: ' + oldHrMapIds);
        List<Recruiter__C> recruiterList =  [SELECT Id, name,City_Name__c, Designation__c, Phone_Number__c, Email_Address__c, Hiring_Manager_id__c FROM Recruiter__c where Hiring_Manager_id__c=:oldHrMapIds];
        system.debug('recuruiter List Size: ' + recruiterList.size());
        system.debug('recuruiterList: ' + recruiterList);
        if(!recruiterList.isEmpty())
        {
            delete recruiterList;
        }
    }
}