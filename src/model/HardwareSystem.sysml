package HardwareSystem {
    private import ScalarValues::*;
    private import SI::*;
    private import SensorSystem::*;

    // =============================================
    // REQUIREMENTS
    // =============================================
    requirement Requirements {
        req FR1: "The system shall provide electrical power to all connected components";
        req FR2: "The refrigerator shall maintain temperature between 2°C and 5°C";
        req NFR1: "Power connections shall use 12-gauge wire or thicker";
        req NFR2: "System voltage shall maintain 120V ±5%";
        req SR1: "All electrical connections shall be insulated";
        req IR1: "Refrigerator shall be compatible with LG DX300 model";
    }

    // =============================================
    // INTERFACES
    // =============================================
    interface def PowerInterface {
        flow electricalPower: Current;
    }

    // =============================================
    // COMPONENTS WITH ACTIONS AND PORTS
    // =============================================
    part def PowerSystem {
        port out powerOut: PowerInterface;
        attribute voltage: Volt;
        
        action SupplyPower(targetVoltage: Volt) {
            // Implementation for power supply control
        }
    }

    part def WiringHarness {
        port in powerIn: PowerInterface;
        port out powerOut: PowerInterface;
        attribute wireGauge: Integer;
        
        action TransmitPower() {
            // Implementation for power transmission monitoring
        }
    }

    part def Refrigerator {
        port in powerIn: PowerInterface;
        attribute temperature: Celsius;
        attribute brand: String = "LG";
        attribute modelNumber: String = "DX300";
        
        action Cool(targetTemp: Celsius) {
            // Implementation for cooling mechanism
        }
        action MonitorTemperature() {
            // Implementation for temperature sensing
        }
    }

    part def Camera {
        port in powerIn: PowerInterface;
        attribute resolution: String;
        
        action CaptureImage() {
            // Implementation for image capture
        }
    }

    // =============================================
    // SYSTEM CONNECTIONS AND RELATIONSHIPS
    // =============================================
    part def FridgeSystemConnections {
        ref part refrigerator: Refrigerator;
        ref part wiringHarness: WiringHarness;
        ref part powerSystem: PowerSystem;
        ref part camera: Camera;
        ref part doorSensor: DoorSensor;

        // Structural Connections
        association RefrigeratorToCamera {
            from refrigerator;
            to camera;
        }

        association PowerFlow {
            from powerSystem.powerOut;
            to wiringHarness.powerIn;
            to refrigerator.powerIn;
            to camera.powerIn;
            to doorSensor.powerInput;
        }

        association SensorToRefrigerator {
            from doorSensor.sensorOutput;
            to refrigerator;
        }

        association SensorToNetowrk {
            from doorSensor.communicationLink;
            to internetConnects;
        }

        // Requirement Satisfactions
        satisfy FR1 {
            source powerSystem;
            target Requirements.FR1;
        }

        satisfy FR2 {
            source refrigerator;
            target Requirements.FR2;
        }
    }

    // =============================================
    // SYSTEM ACTIONS AND ACTIVITIES
    // =============================================
    activity PowerDistributionActivity {
        input: targetVoltage: Volt;
        output: powerStatus: Boolean;
        
        actionNodes {
            powerSystem.SupplyPower(targetVoltage);
            wiringHarness.TransmitPower();
            refrigerator.Cool(4);
            camera.CaptureImage();
        }
        
        controlFlow {
            start -> powerSystem -> wiringHarness -> refrigerator -> camera -> end;
        }
    }

    // =============================================
    // REQUIREMENT TRACEABILITY
    // =============================================
    satisfy NFR1 {
        source WiringHarness.wireGauge;
        target Requirements.NFR1;
    }

    satisfy NFR2 {
        source PowerSystem.voltage;
        target Requirements.NFR2;
    }

    satisfy IR1 {
        source Refrigerator.modelNumber;
        target Requirements.IR1;
    }
}