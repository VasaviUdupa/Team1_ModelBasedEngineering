package SmartHomeKitchenPhysicalArchitecture {

    private import ISQ::*;
    private import SI::*;
    private import ScalarValues::*;

    // 📌 **Sensors for Food Detection & Inventory Tracking**
    package Sensors {
        part def Camera {
            attribute mass : ISQ::MassValue default 150 [SI::g];
        }

        part def MotionSensor {
            attribute mass : ISQ::MassValue default 50 [SI::g];
        }

        part def TemperatureSensor {
            attribute mass : ISQ::MassValue default 100 [SI::g];
        }

        part def WeightSensor {
            attribute mass : ISQ::MassValue default 200 [SI::g];
        }
    }

    // 📌 **Processing Units**
    package Processing {
        part def ProcessingUnit {
            attribute mass : ISQ::MassValue default 500 [SI::g];
        }

        part def AIProcessingUnit specializes ProcessingUnit {
            attribute mass : ISQ::MassValue default 600 [SI::g];
        }

        part def CentralProcessingUnit specializes ProcessingUnit {
            attribute mass : ISQ::MassValue default 450 [SI::g];
        }

        part def StorageUnit {
            attribute mass : ISQ::MassValue default 750 [SI::g];
            attribute capacity : Real default 512 [SI::B];
        }
    }

    // 📌 **Actuators for Smart Home Kitchen**
    package Actuators {
        part def DisplayScreen {
            attribute mass : ISQ::MassValue default 250 [SI::g];
        }

        part def Speaker {
            attribute mass : ISQ::MassValue default 150 [SI::g];
        }

        part def AlertSystem {
            attribute mass : ISQ::MassValue default 200 [SI::g];
        }
    }

    // 📌 **Communication Modules**
    package Communication {
        part def WiFiModule {
            attribute mass : ISQ::MassValue default 50 [SI::g];
        }

        part def BluetoothModule {
            attribute mass : ISQ::MassValue default 30 [SI::g];
        }

        part def CloudSyncModule {
            attribute mass : ISQ::MassValue default 100 [SI::g];
        }
    }

    // 📌 **Power System**
    package Power {
        part def Battery {
            attribute mass : ISQ::MassValue default 1000 [SI::g];
            attribute energyCapacity : ISQ::EnergyUnit default 500 [SI::J]; // Battery capacity
        }
    }

    // 📌 **Main Smart Home Kitchen Model**
    part def SmartHomeKitchen {
        // Sensors for monitoring
        part foodDetectionCamera : Sensors::Camera;
        part motionSensor : Sensors::MotionSensor;
        part temperatureSensor : Sensors::TemperatureSensor;
        part weightSensor : Sensors::WeightSensor;

        // Processing Units
        part centralProcessor : Processing::CentralProcessingUnit;
        part aiProcessor : Processing::AIProcessingUnit;
        part storageUnit : Processing::StorageUnit;

        // Actuators & User Interfaces
        part displayScreen : Actuators::DisplayScreen;
        part speakerSystem : Actuators::Speaker;
        part alertSystem : Actuators::AlertSystem;

        // Communication Modules
        part wifiInterface : Communication::WiFiModule;
        part bluetoothInterface : Communication::BluetoothModule;
        part cloudSync : Communication::CloudSyncModule;

        // Power System
        part batterySystem : Power::Battery;
    }

    // 📌 **Small Kitchen Configuration**
    part def SmartHomeKitchenSmall :> SmartHomeKitchen {
        redefines storageUnit.capacity = 256 [SI::B]; // Reduced storage for smaller model, using B as GB is not SI unit
        redefines aiProcessor.mass = 500 [SI::g]; // Lower mass for AI processor
        redefines batterySystem.energyCapacity = 300 [SI::J]; // Lower power capacity. Using W instread of Wh as Wh is not recognized
    }

    // 📌 **Large Kitchen Configuration**
    part def SmartHomeKitchenLarge :> SmartHomeKitchen {
        redefines storageUnit.capacity = 1024 [SI::B]; // Increased storage
        redefines aiProcessor.mass = 700 [SI::g]; // More powerful AI processor
        redefines batterySystem.energyCapacity = 800 [SI::J]; // Higher power capacity
    }

}
