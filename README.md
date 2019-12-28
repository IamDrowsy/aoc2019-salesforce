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