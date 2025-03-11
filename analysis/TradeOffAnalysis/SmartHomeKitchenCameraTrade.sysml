package 'SmartHomeKitchenCameraTrade' {
    private import ISQ::*;
    private import SI::*;
    private import NumericalFunctions::*;

    package CameraDesignModel {
        part def Camera {
            size : VolumeValue;
            cost : Currency;
            accuracy : Percentage; // Emphasized for capturing expiration dates
            powerConsumption : PowerValue;
        }

        part def CompactCamera :> Camera;
        part def HighDefinitionCamera :> Camera;

        part compactCamera : CompactCamera {
            size : VolumeValue = 0.002m3; // 2 liters
            cost : Currency = 150.00;
            accuracy : Percentage = 85.0; // Less suitable for capturing small details
            powerConsumption : PowerValue = 5W;
        }

        part highDefinitionCamera : HighDefinitionCamera {
            size : VolumeValue = 0.005m3; // 5 liters
            cost : Currency = 300.00;
            accuracy : Percentage = 98.0; // Highly suitable for detailed imaging
            powerConsumption : PowerValue = 10W;
        }
    }

    package CameraAnalysisModel {
        private import CameraDesignModel::*;

        requirement def CameraSelectionObjective {
            subject accuracy : Percentage;
            doc /* Prioritize accuracy for capturing critical details like expiration dates. */
        }

        analysis def CameraTradeStudy {
            subject camera : Camera[1..*] = {compactCamera, highDefinitionCamera};
            objective : CameraSelectionObjective;

            calc def CameraEvaluation {
                in size : VolumeValue;
                in cost : Currency;
                in accuracy : Percentage;
                in powerConsumption : PowerValue;
                return evaluation : Real {
                    // Adjust weights: accuracy is now more heavily weighted
                    return (-0.1 * size.value * 1000) - (0.1 * cost.value) + (0.6 * accuracy.value) - (0.2 * powerConsumption.value);
                }
            }

            calc :>> evaluationFunction {
                in camera : Camera;

                calc sizeRollup { in camera = camera; return size:>ISQ::volume; }
                calc costRollup { in camera = camera; return cost:>Currency; }
                calc accuracyRollup { in camera = camera; return accuracy:>Percentage; }
                calc powerRollup { in camera = camera; return powerConsumption:>ISQ::power; }

                return :>> result : Real = CameraEvaluation(
                    sizeRollup.size, costRollup.cost, accuracyRollup.accuracy, powerRollup.powerConsumption
                );
            }

            return part :>> selectedAlternative : Camera;
        }

        part analysisContext {
            analysis cameraTradeStudy : CameraTradeStudy {
                // Linking to camera designs
                subject camera = {compactCamera, highDefinitionCamera};
            }
        }
    }
}
