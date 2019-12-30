/**
 * Created by micro on 29.12.2019.
 */

trigger AoC03_Trigger on Advent_of_Code_Problem__c (after insert, after update) {

    if (Trigger.isAfter) {
        for (Advent_of_Code_Problem__c problem : Trigger.new) {
            if (problem.Day__c == '03' && String.isBlank(problem.Status__c)) {
                AoC_Problem_Update__e statusEvent = new AoC_Problem_Update__e(ProblemId__c = problem.Id, Status__c = 'Started');
                EventBus.publish(statusEvent);
                AoC03.buildWires(problem);
            }
        }
    }

}