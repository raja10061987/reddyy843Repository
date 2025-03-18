public class ExceptionHandlerClass
{
    public static void myException()
    {
        Account actObj;
        try
        {
            actObj = new Account();
            actObj.Name = 'pavan';
            insert actObj;
        }
        catch(DMLException ex)
        {
            system.debug('Exception: ' + ex.getCause());
            
        }
        finally
        {
            actObj = null;
        }
    }
}