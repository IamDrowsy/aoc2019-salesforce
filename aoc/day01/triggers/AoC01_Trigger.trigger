/**
 * Created by micro on 27.12.2019.
 */

trigger AoC01_Trigger on Advent_of_Code_Problem__c (after insert, after update) {

    if (Trigger.isAfter) {
        List<Advent_of_Code_Problem__c> problemsToUpdate = new List<Advent_of_Code_Problem__c>();
        Set<Id> idsToUpdate = new Set<Id>();
        for (Advent_of_Code_Problem__c problem : Trigger.new) {
            if (problem.Day__c == '01' && String.isBlank(problem.Part_1_Solution__c)) {
                problemsToUpdate.add(problem);
                if (problem.Id != null) {
                    idsToUpdate.add(problem.Id);
                }
            }
        }
        List<AoC01_Module__c> modules = [SELECT Id FROM AoC01_Module__c WHERE Advent_of_Code_Problem__c IN :idsToUpdate];
        if (!modules.isEmpty()) {
            delete modules;
        }

        modules = new List<AoC01_Module__c>();
        for (Advent_of_Code_Problem__c problem : problemsToUpdate) {
            if (problem.Day__c == '01') {
                List<String> lines = problem.Input__c.trim().split('\n');

                for (String line : lines) {
                    modules.add(new AoC01_Module__c(
                            Weight__c = Integer.valueOf(line.trim()), Advent_of_Code_Problem__c = problem.Id));
                }
            }
        }
        if (!modules.isEmpty()) {
            insert modules;
        }
    }
}