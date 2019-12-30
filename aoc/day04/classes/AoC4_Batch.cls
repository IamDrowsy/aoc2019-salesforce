/**
 * Created by micro on 30.12.2019.
 */

public with sharing class AoC4_Batch implements Database.Batchable<AoC04_Candidate__c> {

    Id problemId;

    public AoC4_Batch(Id problemId) {
        this.problemId = problemId;
    }

    public void execute(Database.BatchableContext context, List<SObject> objects) {
        // just try insert and ignore
        Database.insert(objects, false);
    }


    public void finish(Database.BatchableContext context) {
        Integer part1 = [SELECT COUNT() FROM AoC04_Candidate__c WHERE Advent_of_Code_Problem__c = :problemId];
        Integer part2 = [SELECT COUNT() FROM AoC04_Candidate__c WHERE Advent_of_Code_Problem__c = :problemId AND Valid_for_part2__c = TRUE];

        Advent_of_Code_Problem__c problem = new Advent_of_Code_Problem__c(
                Id = problemId,
                Part_1_Solution__c = part1 + '',
                Part_2_Solution__c = part2 + '',
                Status__c = 'Completed',
                Completed__c = true,
                Completed_Time__c = Datetime.now()
        );
        update problem;
    }

    public List<AoC04_Candidate__c> start(Database.BatchableContext context) {
        Advent_of_Code_Problem__c problem = [SELECT Id,Input__c FROM Advent_of_Code_Problem__c WHERE Id = :problemId];
        List<String> numbers = problem.Input__c.split('-');
        Integer start = Integer.valueOf(numbers.get(0));
        Integer ending = Integer.valueOf(numbers.get(1));
        List<AoC04_Candidate__c> candidates = new List<AoC04_Candidate__c>();
        for (Integer i = start; i < ending; i++) {
            candidates.add(new AoC04_Candidate__c(Name = i + '', Advent_of_Code_Problem__c = problemId));
        }

        problem.Started__c = Datetime.now();
        problem.Status__c = 'Started';
        update problem;

        return candidates;
    }
}