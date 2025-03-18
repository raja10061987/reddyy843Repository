public class ContactsDetailsValidation 
{
    public static void ContactsPhoneEmailValidation(List<Contact> contList)
    {
        for(Contact con:contList){
            system.debug('contact phone: ' + con.Phone);
            system.debug('contact Email: ' + con.Email);
            if(con.Phone == null || con.Phone == ''){
                con.phone.addError('please enter the phone field');
            }
            else if(con.Email == null || con.Email == '')
            {
                con.Email.addError('Please Enter the Email field');
            }
        }    
    }
    
    public static void MakesureContactsAssosiatedWithAccounts(List<Contact> conList)
    {
         for(Contact conObj:conList){
            system.debug('contact Record: ' + conObj);
            system.debug('contac name: ' + conObj.LastName);
            system.debug('contac accountId: ' + conObj.AccountId);
            if(String.isBlank(conObj.AccountId)){
                conObj.adderror('contact is not assosiated with any account');
            }
        }
        
    }

}