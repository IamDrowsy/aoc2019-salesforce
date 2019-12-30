/**
 * Created by micro on 30.12.2019.
 */

trigger AoC_Problem_UpdateEvent_Trigger on AoC_Problem_Update__e (after insert) {

    for (AoC_Problem_Update__e event : Trigger.new) {
        Advent_of_Code_Problem__c p = new Advent_of_Code_Problem__c(
                Id = event.ProblemId__c
        );
        if (String.isNotBlank(event.Status__c)) {
            p.Status__c = event.Status__c;
            if (event.Status__c == 'Completed') {
                p.Completed_Time__c = Datetime.now();
            } else if (event.Status__c  == 'Started') {
                p.Started__c = Datetime.now();
            }
            update p;
        }

        EventBus.TriggerContext.currentContext().setResumeCheckpoint(event.ReplayId);
    }

}