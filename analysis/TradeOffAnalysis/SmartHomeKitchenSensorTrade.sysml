package 'SmartHomeKitchenSensorTrade' {
    private import ISQ::*; // Assuming ISQ contains definitions for MassValue, PowerValue
    private import ScalarValues::*; // Assuming this contains definitions for Real, ensure Percentage and Currency types are available

    package SensorDesignModel {
        part def Sensor {
            mass : ISQ::MassValue;
            power : ISQ::PowerValue;
            accuracy : Real; // Changed from Percentage to Real if Percentage is not a defined type
            cost : Real; // Changed from Currency to Real unless Currency is a defined type
        }

        part def WiredSensor :> Sensor;
        part def WirelessSensor :> Sensor;

        part wiredSensor : WiredSensor {
            mass : ISQ::MassValue = 150; // Assuming g is the unit, check the definition in ISQ
            power : ISQ::PowerValue = 2; // Assuming W is the unit
            accuracy : Real = 95.0;
            cost : Real = 40.00;
        }

        part wirelessSensor : WirelessSensor {
            mass : ISQ::MassValue = 100; // As above
            power : ISQ::PowerValue = 1.5;
            accuracy : Real = 90.0;
            cost : Real = 50.00;
        }
    }

    package SensorAnalysisModel {
        private import SensorDesignModel::*;

        requirement def SensorSelectionObjective {
            subject accuracy : Real; // Ensuring type consistency with Sensor definition
            doc /* Optimize sensor selection based on mass, power, accuracy, and cost. */
        }

        analysis def SensorTradeStudy {
            subject sensor : Sensor[1..*] = {wiredSensor, wirelessSensor};
            objective : SensorSelectionObjective;

            calc def SensorEvaluation {
                in mass : ISQ::MassValue;
                in power : ISQ::PowerValue;
                in accuracy : Real;
                in cost : Real;
                return evaluation : Real {
                    // Evaluation function weighting each criterion
                    return (0.2 * mass.value) + (0.2 * power.value) - (0.4 * accuracy) + (0.2 * cost);
                }
            }

            calc :>> evaluationFunction {
                in sensor : Sensor;

                calc massRollup { in sensor = sensor; return mass:>ISQ::mass; }
                calc powerRollup { in sensor = sensor; return power:>ISQ::power; }
                calc accuracyRollup { in sensor = sensor; return accuracy:>Real; }
                calc costRollup { in sensor = sensor; return cost:>Real; }

                return :>> result : Real = SensorEvaluation(
                    massRollup.mass, powerRollup.power, accuracyRollup.accuracy, costRollup.cost
                );
            }

            return part :>> selectedAlternative : Sensor;
        }

        part analysisContext {
            analysis sensorTradeStudy : SensorTradeStudy {
                // Linking to sensor designs
                subject sensor = {wiredSensor, wirelessSensor};
            }
        }
    }
}
