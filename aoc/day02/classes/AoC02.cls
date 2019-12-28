/**
 * Created by micro on 28.12.2019.
 */

public with sharing class AoC02 {

    public static void solvePart1(Advent_of_Code_Problem__c problem) {

        Intcode_Processor__c p = new Intcode_Processor__c(
                Name = problem.Name + '-Part1',
                Memory__c = setVerbNoun(problem.Input__c, 12,2),
                Status__c = Intcode.STATUS_RUNNING
        );
        insert p;
        p = [SELECT Memory__c FROM Intcode_Processor__c WHERE Id = :p.Id];

        problem.Part_1_Solution__c = Intcode.parseMemory(p.Memory__c).get(0) + '';
    }

    public static void solvePart2(Advent_of_Code_Problem__c problem) {
        List<AoC02_Part2_Try__e> events = new List<AoC02_Part2_Try__e>();
        for (Integer noun = 1; noun < 101; noun++) {
            events.add(new AoC02_Part2_Try__e(
                        ProblemId__c = problem.Id,
                        Noun__c = noun
            ));
        }
        System.debug(events);
        EventBus.publish(events);
    }

    public static Long runInMemory(Advent_of_Code_Problem__c problem, Long noun, Long verb) {
        List<Long> memory = Intcode.parseMemory(problem.Input__c);
        memory.set(1, noun);
        memory.set(2, verb);
        Intcode i = new Intcode(memory);
        i.run();
        return i.memory.get(0);
    }

    private static String setVerbNoun(String memory, Long noun, Long verb) {
        List<Long> longs = Intcode.parseMemory(memory);
        longs.set(1, noun); longs.set(2, verb);
        return String.join(longs, ',');
    }
}