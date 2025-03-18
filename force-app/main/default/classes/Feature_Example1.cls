public class Feature_Example1 {
     @future
    public static void call(){
        system.debug('call one:');
        system.debug('call two');
        system.debug('call three');
    }
    @future
    public static void invoke(){  	
        system.debug('invoke 1');
        system.debug('invoke 2');
        system.debug('invoke 3');
       // call();
    }
    
    public void show(){
        system.debug('show 1');
        system.debug('show 2');
        system.debug('show 3');
        call();
        system.debug('show 4');
        system.debug('show 5');
        invoke();
        system.debug('show 6');
        system.debug('show 7');
        call();
        // in single transaction we can call upto 50 feature method calls
    }
    
    
    
}

// 1. feature methods cannot support sObject as a parameter
// 2. feature methods cannot be called in the featured methos. that means chaining of the feature jobs not alloewd
// 3. feature methods cannot return jobId
//  4. mixed DML error issue can be resolved by feature methods/
//  5. set up object(user,userrole,permissionset,permissionsetassignment), nonsetup object(account,opportunity,case)
//  6. in single transaction DML operations are not performed on set up + non set up objects
//  7. if the method is annoted with @future,that method will become future method
// 
// queable apex
// 1. queable apex support sObjects
// 2. queable methods can be called inside queable. that means chaing of the queable jobs alloed. chaining of the 5 queable jobs allowed.
//  3. queable can return jobId
//  4. if the apex class implements queable, that class will become queable apex class. this class must and 
//  should contain execute method
//  5.system.enqueueJob(obj) --> using this we can execute queable apex class
//