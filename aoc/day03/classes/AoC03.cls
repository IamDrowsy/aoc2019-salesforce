/**
 * Created by micro on 29.12.2019.
 */

public with sharing class AoC03 {

    public static void buildWires(Advent_of_Code_Problem__c problem) {

        AoC03__e event = new AoC03__e(
                Extensions__c = problem.Input__c,
                ProblemId__c = problem.Id,
                Wire__c = '1'
        );
        EventBus.publish(event);
    }

}