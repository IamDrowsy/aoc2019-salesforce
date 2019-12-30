/**
 * Created by micro on 30.12.2019.
 */

trigger AoC04_Trigger on Advent_of_Code_Problem__c (after insert, after update) {


    if (Trigger.isAfter) {
        for (Advent_of_Code_Problem__c problem : Trigger.new) {
            if (problem.Day__c == '04' && String.isBlank(problem.Status__c)) {
                AoC4_Batch batch = new AoC4_Batch(problem.Id);
                Database.executeBatch(batch,2000);
            }
        }
    }
}