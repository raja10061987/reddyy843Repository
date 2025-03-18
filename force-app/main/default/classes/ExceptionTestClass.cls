public class ExceptionTestClass 
{
    public void doMorestuff()
    {
        account actObj = new account();
        try
        {
            actObj = [select id,name from account];
        }
        catch(Mathexception ex)
        {
            system.debug('Math exception');
            system.debug('getcasue: ' + ex.getCause());
            system.debug('getLineNumber:' + ex.getLineNumber());
            system.debug('getmessage: ' + ex.getMessage());
            system.debug(' getStackTraceString: ' + ex.getStackTraceString());
            system.debug('type of the exception :' + ex.getTypeName());
        }
        catch(DMLexception ex)
        {
            system.debug('DML exception occured');
            system.debug('getcasue: ' + ex.getCause());
            system.debug('getLineNumber:' + ex.getLineNumber());
            system.debug('getmessage: ' + ex.getMessage());
            system.debug(' getStackTraceString: ' + ex.getStackTraceString());
            system.debug('type of the exception :' + ex.getTypeName());
        }
        catch(NullPointerException ex)
        {
            system.debug('NullpointerException occured');
            system.debug('getcasue: ' + ex.getCause());
            system.debug('getLineNumber:' + ex.getLineNumber());
            system.debug('getmessage: ' + ex.getMessage());
            system.debug(' getStackTraceString: ' + ex.getStackTraceString());
            system.debug('type of the exception :' + ex.getTypeName());
        }
        catch(queryException ex)
        {
            system.debug('query exception occured');
            system.debug('getcasue: ' + ex.getCause());
            system.debug('getLineNumber:' + ex.getLineNumber());
            system.debug('getmessage: ' + ex.getMessage());
            system.debug(' getStackTraceString: ' + ex.getStackTraceString());
            system.debug('type of the exception :' + ex.getTypeName());
        }
        finally
        {
            system.debug('finally block executed');
        }
    }

}