package SmartHomeKitchenAnalysis {

    private import SmartHomeKitchen::*;
    private import SmartHomeKitchenRequirements::*;
    private import SmartHomeKitchenPhysicalArchitecture::*;
    private import SmartHomeKitchenPhysicalArchitecture::*;
    private import ISQ::*;
    private import TradeStudies::*;
    private import SI::*;
    private import ScalarValues::*;

    // ✅ **Total Energy Consumption Calculation for Smart Home Kitchen**
    calc def TotalEnergyUsage {
        in kitchen : SmartHomeKitchen;
        in numDetections : ScalarValues::Integer; // Number of food detection cycles
        attribute operationDuration : TimeValue = 3600 [SI::s]; // Assume 1 hour of operation
        attribute energyCamera : EnergyUnit;
        attribute energyComputer : EnergyUnit;
        attribute energyComputerVision : EnergyUnit;
        return totalEnergy : EnergyUnit;
    }

    // ✅ **Energy Calculation for a Small Kitchen Setup**
    calc def TotalEnergyUsageSmall :> TotalEnergyUsage {
        in kitchen :> SmartHomeKitchenPhysicalArchitecture.SmartHomeKitchenSmall;
        in numDetections : ScalarValues::Integer;
        redefines energyCamera = kitchen.cameraSystem.powerConsumption * operationDuration;
        redefines energyComputer = kitchen.computerSystem.powerConsumption * operationDuration;
        redefines energyComputerVision = numDetections * (kitchen.computerVisionSystem.processingSpeed * kitchen.computerVisionSystem.powerConsumption);
        return redefines totalEnergy = energyCamera + energyComputer + energyComputerVision;
    }

    // ✅ **Energy Calculation for a Large Kitchen Setup**
    calc def TotalEnergyUsageLarge :> TotalEnergyUsage {
        in kitchen :> SmartHomeKitchenLarge;
        in numDetections : ScalarValues::Integer;
        redefines energyCamera = kitchen.cameraSystem.powerConsumption * operationDuration;
        redefines energyComputer = kitchen.computerSystem.powerConsumption * operationDuration;
        redefines energyComputerVision = numDetections * (kitchen.computerVisionSystem.processingSpeed * kitchen.computerVisionSystem.powerConsumption);
        return redefines totalEnergy = energyCamera + energyComputer + energyComputerVision;
    }

    // ✅ **Trade Study to Compare Kitchen Configurations**
    analysis SmartHomeKitchenEfficiencyTradeStudy : TradeStudy {
        subject studyAlternatives : SmartHomeKitchen = (SmartHomeKitchenSmall, SmartHomeKitchenLarge);
        objective : MinimizeObjective; // Aim to minimize energy consumption

        calc :>> evaluationFunction {
            in part aKitchen :>> alternative : SmartHomeKitchenSmall;
            in attribute numDetections : ScalarValues::Integer = 50;
            return :>> result : Real = TotalEnergyUsageSmall(kitchen = aKitchen, numDetections = numDetections);
        }

        calc :>> evaluationFunction {
            in part aKitchen :>> alternative : SmartHomeKitchenLarge;
            in attribute numDetections : ScalarValues::Integer = 50;
            return :>> result : Real = TotalEnergyUsageLarge(kitchen = aKitchen, numDetections = numDetections);
        }

        return selectedAlternative : SmartHomeKitchen;
    }
}
