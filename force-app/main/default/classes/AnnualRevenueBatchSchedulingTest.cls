@isTest
public class AnnualRevenueBatchSchedulingTest {
   public static testMethod void AnualRevenueTest()
   {
       AnnualRevenueBatchScheduling obj = new AnnualRevenueBatchScheduling();
        // String sch = '0 0 23 * * ?';
         String CRON_EXP = '0 0 0 31 7 ? 2021';
            test.startTest();
        system.schedule('Test annual revenue', CRON_EXP, obj);
       test.stopTest();

   }
}