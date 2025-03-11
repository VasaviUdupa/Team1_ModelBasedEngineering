package 'SmartHomeKitchenComputerTrade' {
    private import ISQ::*; // Ensure ISQ contains definitions for MassValue, PowerValue, and VolumeValue
    private import ScalarValues::*; // Import for handling Real, assuming Currency is correctly defined here as well
    private import NumericalFunctions::*; // Verify this contains necessary functions or definitions if used

    package ComputerSystemDesignModel {
        part def ComputerSystem {
            size : ISQ::VolumeValue; // Ensure VolumeValue is defined in ISQ
            mass : ISQ::MassValue; // Ensure MassValue is defined in ISQ
            powerConsumption : ISQ::PowerValue; // Ensure PowerValue is defined in ISQ
            cost : Real; // Assuming cost is handled as a Real type, define as Currency if it's a specific type
            performance : Real; // Performance index, higher is better
        }

        part def StandardComputerSystem :> ComputerSystem;
        part def HighPerformanceComputerSystem :> ComputerSystem;

        part standardComputer : StandardComputerSystem {
            size : ISQ::VolumeValue = 0.015; // Assuming m^3 is default, specify units in documentation if different
            mass : ISQ::MassValue = 6; // Assuming kg is default
            powerConsumption : ISQ::PowerValue = 150; // Assuming W is default
            cost : Real = 800.00; // Currency if specific type
            performance : Real = 85.0; 
        }

        part highPerformanceComputer : HighPerformanceComputerSystem {
            size : ISQ::VolumeValue = 0.025; // Comment on units if needed
            mass : ISQ::MassValue = 10;
            powerConsumption : ISQ::PowerValue = 400;
            cost : Real = 1500.00; // As Real or Currency
            performance : Real = 95.0;
        }
    }

    package ComputerSystemAnalysisModel {
        private import ComputerSystemDesignModel::*;

        requirement def ComputerSystemSelectionObjective {
            subject performance : Real;
            doc /* Prioritize computer system selection based on performance, considering power, cost, size, and mass. */
        }

        analysis def ComputerSystemTradeStudy {
            subject computerSystem : ComputerSystem[1..*] = {standardComputer, highPerformanceComputer};
            objective : ComputerSystemSelectionObjective;

            calc def ComputerSystemEvaluation {
                in size : ISQ::VolumeValue;
                in mass : ISQ::MassValue;
                in powerConsumption : ISQ::PowerValue;
                in cost : Real;
                in performance : Real;
                return evaluation : Real {
                    // Evaluation function weighting each criterion
                    return (-0.1 * size.value * 1000) - (0.1 * mass.value) - (0.2 * powerConsumption.value) - (0.1 * cost.value) + (0.5 * performance);
                }
            }

            calc :>> evaluationFunction {
                in computer : ComputerSystem;

                calc sizeRollup { in computer = computer; return size:>ISQ::volume; }
                calc massRollup { in computer = computer; return mass:>ISQ::mass; }
                calc powerRollup { in computer = computer; return powerConsumption:>ISQ::power; }
                calc costRollup { in computer = computer; return cost:>Real; }
                calc performanceRollup { in computer = computer; return performance:>Real; }

                return :>> result : Real = ComputerSystemEvaluation(
                    sizeRollup.size, massRollup.mass, powerRollup.powerConsumption, costRollup.cost, performanceRollup.performance
                );
            }

            return part :>> selectedAlternative : ComputerSystem;
        }

        part analysisContext {
            analysis computerSystemTradeStudy : ComputerSystemTradeStudy {
                // Linking to computer system designs
                subject computerSystem = {standardComputer, highPerformanceComputer};
            }
        }
    }
}
