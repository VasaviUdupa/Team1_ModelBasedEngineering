package 'SmartHomeKitchen_TradeOffAnalysis' {
    private import ScalarValues::Real;
    private import TradeStudies::*;
    private import Definitions::*;
    private import Usages::*;

    package Definitions {

        part def SmartHomeKitchen;

        part def CameraSystem {
            power : ISQ::PowerValue;
            mass : ISQ::MassValue;
            accuracy : Real;
            cost : Real;
        }

        part def ComputerSystem {
            power : ISQ::PowerValue;
            mass : ISQ::MassValue;
            performance : Real;
            cost : Real;
        }

        part def ComputerVisionSystem {
            power : ISQ::PowerValue;
            mass : ISQ::MassValue;
            accuracy : Real;
            cost : Real;
        }

        part def DatabaseSystem {
            storageCapacity : Real;
            accessSpeed : Real;
            reliability : Real;
            cost : Real;
        }

        part def HardwareSystem {
            power : ISQ::PowerValue;
            mass : ISQ::MassValue;
            reliability : Real;
            cost : Real;
        }

        part def MotionSensor {
            sensitivity : Real;
            power : ISQ::PowerValue;
            mass : ISQ::MassValue;
            cost : Real;
        }

    }

    package Usages {

        part kitchen : SmartHomeKitchen {
            part camera : CameraSystem;
            part computer : ComputerSystem;
            part vision : ComputerVisionSystem;
            part database : DatabaseSystem;
            part hardware : HardwareSystem;
            part sensor : MotionSensor;
        }

        variation part componentChoice :> kitchen {
            variant part 'HighAccuracyCamera' {
                part :>> camera;
            }

            variant part 'HighPerformanceComputer' {
                part :>> computer;
            }

            variant part 'AdvancedVisionSystem' {
                part :>> vision;
            }

            variant part 'LargeStorageDatabase' {
                part :>> database;
            }

            variant part 'DurableHardware' {
                part :>> hardware;
            }

            variant part 'SensitiveMotionSensor' {
                part :>> sensor;
            }
        }

        part configuredKitchen : SmartHomeKitchen {
            part components[1] :> componentChoice = componentChoice::'SensitiveMotionSensor' {
                assert constraint componentSelectionRationale { 
                    doc /* Selected the best component based on the 'componentTradeStudy'. */
                    components == Analysis::componentTradeStudy.selectedAlternative
                }
            }

        }
    }

    package Analysis {

        calc def ComponentEvaluation {
            doc /* Evaluation function with criteria power, mass, efficiency, performance, and cost. */
            in power : ISQ::PowerValue;
            in mass : ISQ::MassValue; 
            in performance : Real; 
            in cost : Real;
            return evaluation : Real;
            // Compute evaluation...
        }

        analysis componentTradeStudy : TradeStudy {
            subject : Part[1..*] = all componentChoice;
            objective : MaximizeObjective;

            calc :>> evaluationFunction {
                in part aComponent :>> alternative : Part;

                calc powerRollup { in component = aComponent; return power:>ISQ::power; }
                calc massRollup { in component = aComponent; return mass:>ISQ::mass; }
                calc performanceRollup { in component = aComponent; return performance: Real; }
                calc costRollup { in component = aComponent; return cost: Real; }

                return :>> result : Real = ComponentEvaluation(
                    powerRollup.power, massRollup.mass, performanceRollup.performance, costRollup.cost
                );
            }

            return part :>> selectedAlternative : Part;
        }

    }

}
