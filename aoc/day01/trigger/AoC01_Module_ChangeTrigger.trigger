/**
 * Created by micro on 27.12.2019.
 */

trigger AoC01_Module_ChangeTrigger on AoC01_Module__ChangeEvent (after insert) {

    List<Id> problems = new List<Id>();
    List<AoC01_Module__c> missingFuelModules = new List<AoC01_Module__c>();
    Set<Id> unfinishedProblems = new Set<Id>();
    for (AoC01_Module__ChangeEvent event : Trigger.new) {
        problems.add(event.Advent_of_Code_Problem__c);
        EventBus.ChangeEventHeader header = event.ChangeEventHeader;
        System.debug(event.Weight__c);
        if (header.changeType == 'CREATE' && event.Weight__c > 0) {
            unfinishedProblems.add(event.Advent_of_Code_Problem__c);
            missingFuelModules.add(new AoC01_Module__c(
                    Advent_of_Code_Problem__c = event.Advent_of_Code_Problem__c,
                    Fuel_for_Module__c = header.recordIds[0],
                    Only_Part_2__c = true
            ));
        }
    }

    if (!missingFuelModules.isEmpty()) {
        insert(missingFuelModules);
    }

    // Part 1
    List<AggregateResult> result =
        [SELECT Advent_of_Code_Problem__c, SUM(Needed_Fuel__c) fuel, SUM(Needed_Fuel_Part_1__c) fuelPart1
         FROM AoC01_Module__c
         WHERE Advent_of_Code_Problem__c IN :problems
         GROUP BY Advent_of_Code_Problem__c];


    List<Advent_of_Code_Problem__c> problemsToUpdate = new List<Advent_of_Code_Problem__c>();
    for (AggregateResult result : result) {
        Advent_of_Code_Problem__c problemToUpdate = new Advent_of_Code_Problem__c(
                Id = (Id) result.get('Advent_of_Code_Problem__c'),
                Part_1_Solution__c = Integer.valueOf(result.get('fuelPart1')) + '',
                Part_2_Solution__c = Integer.valueOf(result.get('fuel')) + ''
        );
        if (!unfinishedProblems.contains(problemToUpdate.Id)) {
            problemToUpdate.Completed__c = true;
        }
        problemsToUpdate.add(problemToUpdate);
    }
    update problemsToUpdate;

}