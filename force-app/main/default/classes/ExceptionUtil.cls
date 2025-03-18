public with sharing class ExceptionUtil {
    public class MyException extends Exception
    {

    }

    @InvocableMethod(label='Invoke ExceptionUtil')
    public static void throwCustomException(List<String> exceptionMessage)
    {
        throw new MyException('An internal exception happened during current operation.' + 'please contact system adminstrator with this exception Details:' + exceptionMessage[0]);

    }
}