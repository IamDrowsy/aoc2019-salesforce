/**
 * Created by micro on 28.12.2019.
 */

@IsTest
private class AoC02_Test {
    @IsTest
    static void testSolution() {
        String input = '1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,19,10,23,1,23,13,27,1,6,27,31,1,9,31,35,2,10,35,39,1,39,6,43,1,6,43,47,2,13,47,51,1,51,6,55,2,6,55,59,2,59,6,63,2,63,13,67,1,5,67,71,2,9,71,75,1,5,75,79,1,5,79,83,1,83,6,87,1,87,6,91,1,91,5,95,2,10,95,99,1,5,99,103,1,10,103,107,1,107,9,111,2,111,10,115,1,115,9,119,1,13,119,123,1,123,9,127,1,5,127,131,2,13,131,135,1,9,135,139,1,2,139,143,1,13,143,0,99,2,0,14,0';

        Advent_of_Code_Problem__c problem = new Advent_of_Code_Problem__c(
                Name = 'Day 02 Full',
                Day__c = '02',
                Input__c = input
        );
        insert problem;

        problem = [SELECT Id,Part_2_Solution__c,Part_1_Solution__c FROM Advent_of_Code_Problem__c WHERE Id = :problem.Id];
        System.assertEquals(7210630 + '', problem.Part_1_Solution__c);

        //Test is to expensive (CPU Time Limit)
        //Test.getEventBus().deliver();
        //problem = [SELECT Id,Part_2_Solution__c,Part_1_Solution__c FROM Advent_of_Code_Problem__c WHERE Id = :problem.Id];
        //System.assertEquals(3892 + '', problem.Part_2_Solution__c);
    }
}