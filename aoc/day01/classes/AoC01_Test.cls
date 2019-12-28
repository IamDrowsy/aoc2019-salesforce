/**
 * Created by micro on 28.12.2019.
 */

@IsTest
private class AoC01_Test {
    @IsTest
    static void testDay01() {
        Advent_of_Code_Problem__c problem = new Advent_of_Code_Problem__c(
                Day__c = '01',
                Input__c = '100756'
        );
        Test.enableChangeDataCapture();
        insert problem;
        Test.getEventBus().deliver();
        problem = [SELECT Part_1_Solution__c, Part_2_Solution__c,Completed__c FROM Advent_of_Code_Problem__c];
        System.assert(!problem.Completed__c);
        Test.getEventBus().deliver();
        Test.getEventBus().deliver();
        Test.getEventBus().deliver();
        Test.getEventBus().deliver();
        Test.getEventBus().deliver();
        Test.getEventBus().deliver();
        Test.getEventBus().deliver();
        Test.getEventBus().deliver();
        Test.getEventBus().deliver();
        Test.getEventBus().deliver();

        problem = [SELECT Part_1_Solution__c, Part_2_Solution__c,Completed__c FROM Advent_of_Code_Problem__c];
        System.assert(problem.Completed__c);
        System.assertEquals('33583', problem.Part_1_Solution__c);
        System.assertEquals('50346', problem.Part_2_Solution__c);
    }
}