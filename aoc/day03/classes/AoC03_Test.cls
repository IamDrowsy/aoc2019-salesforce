/**
 * Created by micro on 29.12.2019.
 */

@IsTest
private class AoC03_Test {
/*
Not Testtable because of BigObjects


    @IsTest
    static void testTinyProblem() {
        String input = 'R8,U5,L5,D3\nU7,R6,D4,L4';
        Advent_of_Code_Problem__c problem = solveProblem(input);
        System.assertEquals('6', problem.Part_1_Solution__c);
        System.assertEquals('30', problem.Part_2_Solution__c);
    }

    @IsTest
    static void testSmallProblem() {
        String input = 'R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83';
        Advent_of_Code_Problem__c problem = solveProblem(input);
        System.assertEquals('159', problem.Part_1_Solution__c);
        System.assertEquals('610', problem.Part_2_Solution__c);
    }

    @IsTest
    static void test2Problems() {
        String input1 = 'R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83';
        String input2 = 'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7';
        Advent_of_Code_Problem__c problem1 = solveProblem(input1);
        Advent_of_Code_Problem__c problem2 = solveProblem(input2);
        System.assertEquals('159', problem1.Part_1_Solution__c);
        System.assertEquals('610', problem1.Part_2_Solution__c);
        System.assertEquals('135', problem2.Part_1_Solution__c);
        System.assertEquals('410', problem2.Part_2_Solution__c);
    }

    @IsTest
    static void testBigStep() {
        String input = 'R1000,U573,L25,U468,L833,D867,R515,D941\nL1004,U110,R738,D383,R606,U840,L123,D756';
        Advent_of_Code_Problem__c problem = solveProblem(input);
    }

    private static Advent_of_Code_Problem__c solveProblem(String input) {
        Advent_of_Code_Problem__c problem = new Advent_of_Code_Problem__c(
                Day__c = '03',
                Input__c = input
        );
        insert problem;

        Test.getEventBus().deliver();
        problem = [SELECT Part_1_Solution__c,Part_2_Solution__c FROM Advent_of_Code_Problem__c WHERE Id = :problem.Id];
        return problem;
    }

 */
}