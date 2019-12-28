/**
 * Created by micro on 28.12.2019.
 */

public with sharing class Intcode {

    Intcode_Processor__c p;
    public List<Long> memory;
    Integer pointer;
    String status;

    private static Map<Long,Opcode> opcodeCache = new Map<Long,Opcode>();

    public static final String STATUS_STOPPED = 'Stopped';
    public static final String STATUS_RUNNING = 'Running';

    private Intcode(Intcode_Processor__c p) {
        memory = parseMemory(p.Memory__c);
        status = p.Status__c;
        pointer = Integer.valueOf(p.Pointer__c);
        this.p = p;
    }

    public Intcode(List<Long> memory) {
        this.memory = memory.clone();
        status = STATUS_RUNNING;
        pointer = 0;
    }

    public static void run(Intcode_Processor__c p) {
        Intcode.run(p, new Map<Integer,Long>());
    }

    public static void run(Intcode_Processor__c p,Map<Integer,Long> memoryOverride) {
        Intcode i = new Intcode(p);
        for (Integer index : memoryOverride.keySet()) {
            i.memory.set(index, memoryOverride.get(index));
        }
        i.run();
    }

    public static List<Long> parseMemory(String memory) {
        List<Long> result = new List<Long>();
        for (String slot : memory.split(',')) {
            result.add(Long.valueOf(slot));
        }
        return result;
    }

    private void runStep() {
        Opcode currentCode = Intcode.opcodeFor(memory.get(pointer));
        currentCode.apply(this);
    }

    public void run() {
        while (this.status != STATUS_STOPPED) {
            runStep();
        }
        if (p != null) {
            p.Memory__c = String.join(memory, ',');
            p.Status__c = status;
            p.Pointer__c = pointer;
        }
    }

    // Opcodes

    private static Opcode opcodeFor(Long opcode) {
        switch on (Math.mod(opcode, 100)) {
            when 1 {
                return new AddOpcode();
            }
            when 2 {
                return new MulOpcode();
            }
            when 99 {
                return new StopOpcode();
            }
        }
        return null;
    }

    private interface Opcode {
        void apply(Intcode i);
    }

    private class StopOpcode implements Opcode {
        public void apply(Intcode i) {
            i.status = STATUS_STOPPED;
        }
    }

    private abstract class CalcOpCode implements Opcode {
        MemoryAccess arg1 = Intcode.accessFor(0,1);
        MemoryAccess arg2 = Intcode.accessFor(0,2);
        MemoryAccess result = Intcode.accessFor(0, 3);
        Integer numberOfParams = 3;

        private abstract Long calc(Long arg1, Long arg2);
        public void apply(Intcode i) {
            result.set(i,calc(arg1.get(i), arg2.get(i)));
            i.pointer = i.pointer + numberOfParams + 1;
        }
    }

    private class AddOpcode extends CalcOpCode {
        private override Long calc(Long arg1, Long arg2) {
            return arg1 + arg2;
        }
    }

    private class MulOpcode extends CalcOpCode {
        private override Long calc(Long arg1, Long arg2) {
            return arg1 * arg2;
        }
    }

    // Memory Accesses

    private static MemoryAccess accessFor(Integer accessType, Integer paramIndex) {
        MemoryAccess result = new PositionAccess();
        result.paramIndex = paramIndex;
        return result;
    }

    private abstract class MemoryAccess  {

        public Integer paramIndex;

        private abstract Integer resolveIndex(Intcode i);
        public Long get(Intcode i) {
            return Integer.valueOf(i.memory.get(resolveIndex(i)));
        }
        public void set(Intcode i, Long value) {
            i.memory.set(resolveIndex(i), value);
        }
    }

    private class PositionAccess extends MemoryAccess {
        public override Integer resolveIndex(Intcode i) {
            return Integer.valueOf(i.memory.get(i.pointer + paramIndex));
        }
    }
}