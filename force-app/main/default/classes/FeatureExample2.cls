public class FeatureExample2 {
    @future
    public static void call(integer id){
        system.debug('call 1');
        system.debug('call 2');
        system.debug('calll 3');
        system.debug('integer' + id);
    }
    @future
    public static void invoke(){
        system.debug('invoke 1');
        system.debug('invoke 2');
        system.debug('invoke 3');
        call(10);
    }
    
    public void show(){
        //List<Account> accList = [select id,name from account limit 2];
        system.debug('show 1');
        system.debug('show 2');
        system.debug('show 3');
        call(3);
        system.debug('show 4');
        system.debug('show 5');
        invoke();
        system.debug('show 6');
        system.debug('show 7');
    }
    
}