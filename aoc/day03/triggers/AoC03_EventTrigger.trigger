trigger AoC03_EventTrigger on AoC03__e (after insert) {

    for (AoC03__e event : Trigger.new) {
        List<AoC03_Wire_Part__b> toAdd = new List<AoC03_Wire_Part__b>();

        String extension = event.Extensions__c.substringBefore('\n').substringBefore(',');
        String direction = extension.substring(0,1);
        Integer length = Integer.valueOf(extension.substring(1).trim());

        for (Integer i = 1; i <= length; i++) {
            AoC03_Wire_Part__b cell = new AoC03_Wire_Part__b(
                    Advent_of_Code_Problem__c = event.ProblemId__c,
                    Wire__c = event.Wire__c,
                    Index__c = event.Index__c + i,
                    x__c = event.x__c,
                    y__c = event.y__c
            );
            switch on direction {
                when 'U' {
                    cell.y__c = cell.y__c + i;
                }
                when 'D' {
                    cell.y__c = cell.y__c - i;
                }
                when 'L' {
                    cell.x__c = cell.x__c - i;
                }
                when 'R' {
                    cell.x__c = cell.x__c + i;
                }
            }
            cell.x_y__c = cell.x__c + '-' +  cell.y__c;
            toAdd.add(cell);
        }

        if (event.Wire__c == '1') {
            Database.insertImmediate(toAdd);
        } else {
            Map<String,AoC03_Wire_Part__b> possible_x_y = new Map<String,AoC03_Wire_Part__b>();
            for (AoC03_Wire_Part__b cell : toAdd) {
                possible_x_y.put(cell.x_y__c, cell);
            }
            List<AoC03_Wire_Part__b> intersections =
            [SELECT x__c,y__c,Index__c,x_y__c
             FROM AoC03_Wire_Part__b
             WHERE Advent_of_Code_Problem__c = :event.ProblemId__c
               AND Wire__c = '1'
               AND x_y__c IN :possible_x_y.keySet()];

            if (!intersections.isEmpty()) {
                Advent_of_Code_Problem__c problem = [SELECT Id,Part_1_Solution__c, Part_2_Solution__c FROM Advent_of_Code_Problem__c WHERE Id = :event.ProblemId__c];
                for (AoC03_Wire_Part__b part : intersections) {
                    Decimal manhattenDistance = Math.abs(part.x__c) + Math.abs(part.y__c);
                    if (String.isBlank(problem.Part_1_Solution__c) || Decimal.valueOf(problem.Part_1_Solution__c) > manhattenDistance) {
                        problem.Part_1_Solution__c = manhattenDistance.intValue() + '';
                    }
                    Decimal totalIndex = part.Index__c + possible_x_y.get(part.x_y__c).Index__c;
                    if (String.isBlank(problem.Part_2_Solution__c) || Decimal.valueOf(problem.Part_2_Solution__c) > totalIndex) {
                        problem.Part_2_Solution__c = totalIndex.intValue() + '';
                    }
                    if (event.Completed__c) {
                        problem.Completed__c = true;
                    }
                }
                update problem;

            }

        }

        if (!event.Completed__c) {
            AoC03_Wire_Part__b lastPart = toAdd.get(toAdd.size() - 1);

            String nextExtension = event.Extensions__c.substring(extension.length() + 1);
            AoC03__e nextEvent = new AoC03__e(
                    ProblemId__c = event.ProblemId__c,
                    Wire__c = event.Wire__c,
                    Extensions__c = nextExtension,
                    Index__c = lastPart.Index__c,
                    x__c = lastPart.x__c,
                    y__c = lastPart.y__c
            );
            if (nextExtension.containsNone(',')) {
                nextEvent.Completed__c = true;
            }
            if (nextExtension.containsNone('\n') && event.Wire__c == '1') {
                nextEvent.Wire__c = '2';
                nextEvent.x__c = 0;
                nextEvent.y__c = 0;
                nextEvent.Index__c = 0;
            }
            AoC_Problem_Update__e statusEvent = new AoC_Problem_Update__e(ProblemId__c = event.ProblemId__c, Status__c = 'Remaining Parts: ' + event.Extensions__c.countMatches(','));
            EventBus.publish(new List<SObject>{statusEvent,nextEvent});
        } else {
            AoC_Problem_Update__e statusEvent = new AoC_Problem_Update__e(ProblemId__c = event.ProblemId__c, Status__c = 'Completed');
            EventBus.publish(statusEvent);
        }

    }

}