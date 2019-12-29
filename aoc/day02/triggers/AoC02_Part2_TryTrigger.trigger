/**
 * Created by micro on 28.12.2019.
 */

trigger AoC02_Part2_TryTrigger on AoC02_Part2_Try__e (after insert) {

    Set<Id> problemIds = new Set<Id>();
    for (AoC02_Part2_Try__e event : Trigger.new) {
        problemIds.add(event.ProblemId__c);
    }
    Map<Id,Advent_of_Code_Problem__c> problems = new Map<Id,Advent_of_Code_Problem__c>(
            [SELECT Id,Part_2_Solution__c, Input__c FROM Advent_of_Code_Problem__c WHERE Id IN :problemIds]);


    for (AoC02_Part2_Try__e event : Trigger.new) {
        Advent_of_Code_Problem__c problem = problems.get(event.ProblemId__c);

        if (String.isBlank(problem.Part_2_Solution__c)) {
            for (Integer verb = 1; verb < 101; verb ++) {
                Long result = AoC02.runInMemory(problem, event.Noun__c.longValue(), verb);
                if (result == 19690720) {
                    problem.Part_2_Solution__c = Integer.valueOf(event.Noun__c * 100 + verb) + '';
                    problem.Completed__c = true;
                    update problem;
                    break;
                }
            }
        }
        EventBus.TriggerContext.currentContext().setResumeCheckpoint(event.ReplayId);
    }



}