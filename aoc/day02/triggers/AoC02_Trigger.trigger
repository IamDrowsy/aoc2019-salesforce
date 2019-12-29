/**
 * Created by micro on 27.12.2019.
 */

trigger AoC02_Trigger on Advent_of_Code_Problem__c (before insert, before update, after insert, after update) {

    if (Trigger.isBefore) {
        for (Advent_of_Code_Problem__c problem : Trigger.new) {
            if (problem.Day__c == '02' && String.isBlank(problem.Part_1_Solution__c)) {
                AoC02.solvePart1(problem);
            }
        }
    }

    if (Trigger.isAfter) {
        for (Advent_of_Code_Problem__c problem : Trigger.new) {
            if (problem.Day__c == '02' && String.isBlank(problem.Part_2_Solution__c)) {
                AoC02.solvePart2(problem);
            }
        }
    }
}