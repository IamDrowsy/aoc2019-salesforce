# Advent of Code Solutions using Salesforce

This sfdx projects contains metadata to use the salesforce plattform to solve advent of code 2019.
This is probably not a very good idea, but might be a good project to play around with features of the platform and hit 
some limits.

The goal is not to find the most efficient solution, but to use different features for the solutions. 

# Available Solutions:
## General
In the `utils` folder you find the `Advent_of_Code_Problem__c` Object, which is used to store the problem input
and present the solutions. The goal should be, that an insert of this object triggers the whole solving process, 
and is marked as `Completed` when the platform finished calculating.

## Day 01
Calculates the fuel consumption of rocket modules based on their weight
* Formula to calculate needed fuel from weight
* Custom Object `AoC01_Module__c` to store `Weight__c`, `Needed_Fuel__c` and if it's the recursive fuel consumption for
the weight of fuel (Lookup to `AoC01_Module__c`) 
* Trigger on `Advent_of_Code_Problem__c` to create `AoC01_Module__c` records (non recursive)
* Trigger on `AoC01_Module_ChangeEvent` that adds recursive childern of the modules and calculates the solutions
    * When it creates no further `AoC01_Module__c`, it marks this problem as completed.
* ProcessBuilder on `AoC01_Module__c` to calculate the `Weight__c` of a module with the Lookup to `AoC01_Module__c` filled.
    * This cannot be done in the ChangeEventTrigger because the result of the formula `Fuel_Needed__c` is not present in this Trigger.
    
## Day 02
Running simple Intcode
* Limits: 
  * Apex CPU Limit => Distribute with Platform Events
* CustomObject `Intcode_Processor__c` to save state of a running intcode process
* `Intcode` ApexClass to do the calculations (also runnable without an `Intcode_Processor__c` record)
* Part 1 in solved syncronously by inserting an `Intcode_Processor__c` and checking the result
* Part 2 is to expensive to run synchron as 10000 Intcode runs have to be checked
  * We use PlatformEvents `AoC02_Part2_Try__c` to bulkify the runs in 100 runs per event und resume when a limit is hit.
  
## Day 03
Calculating intersections of wires 
* Limits
  * Memory Limit => go with BigObjects
  * BigObjects are really fragile
     * can only query in order of the index
     * cannot mix dml and bigobject dml
     * Platform Events only fire after bigobject dml (but no error!) 
* BigObject `AoC03_Wire_Part__b` to store x,y,Index for Wire 1
  * needs field with x_y combined in index to query for matches
* Chained Platform events `AoC03__c` to create `AoC03_Wire_Part__b`
  * Must be chained as there is no way of storing the information of the last part (mixing big object and normal dml)
* After inserting wire1, check if wire2 matches a part of wire1
* Cannot be UnitTested because of BigObjects
* Solving the full run takes about 20 mins