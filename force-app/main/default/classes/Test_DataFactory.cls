@IsTest
public class Test_DataFactory {
    public static  Account prepareAcconts(boolean isInsert){
        Account accountObject = new Account();
        accountObject.Name = 'rajaaccount';
        accountObject.Type = 'Other';
        accountObject.Industry = 'Banking';
        if(isInsert){
            insert accountObject;
        }
        return accountObject;        
    }
}