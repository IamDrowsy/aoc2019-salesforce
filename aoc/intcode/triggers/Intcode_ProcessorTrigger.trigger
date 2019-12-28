/**
 * Created by micro on 28.12.2019.
 */

trigger Intcode_ProcessorTrigger on Intcode_Processor__c (before insert, before update) {

    if (Trigger.isBefore) {
        for (Intcode_Processor__c p : Trigger.new) {
            if (p.Status__c == Intcode.STATUS_RUNNING) {
                Intcode.run(p);
            }
        }
    }
}