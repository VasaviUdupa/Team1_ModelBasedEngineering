package SensorSystem {

    // Define Sensor Port
    port def SensorPort {
        doc /* Interface for sensor signals */
        attribute sensorType: String = "Door Sensor"; // Specific type of sensor
        attribute signalType: String = "Digital"; // Type of output signal
        attribute sensitivity: Real = 0.95; // Sensitivity level
        attribute debounceTime: Real = 0.1; // Time in seconds to stabilize signal
    }

    // Define Communication Port
    port def CommPort {
        doc /* Interface for communicating with other system components */
        attribute protocol: String = "ZigBee"; // Communication protocol used
        attribute range: Real = 50; // Range in meters
    }

    // Define the Sensor Component
    part def DoorSensor {
        doc /* Sensor to detect the opening and closing of the refrigerator door */

        // Attributes defining Sensor specifications
        attribute modelNumber: String = "DS1001"; // Model of the sensor
        attribute installationDate: Date; // Date when the sensor was installed
        attribute powerRequirement: Real = 0.5; // Power requirement in watts

        // Communication Ports
        port sensorOutput: SensorPort; // Sends signals based on door status
        port communicationLink: CommPort; // Communicates with the central system

        // Internal connections
        internal connection sensorToComm: sensorOutput <-> communicationLink;
    }

    // Define Actions for Sensor Operation
    action def DetectChange { out changeDetected: Boolean; }
    action def SignalProcessing { in rawSignal: Boolean; out processedSignal: Boolean; }
    action def TransmitStatus { in status: Boolean; }

    // Define Flow for Sensor Signals
    action SensorWorkflow {
        action detect: DetectChange[1]; // Detects door opening/closing
        action processSignal: SignalProcessing[1]; // Processes the raw signal to account for debouncing
        action transmit: TransmitStatus[1]; // Transmits the processed status to the central system

        flow detect.changeDetected to processSignal.rawSignal;
        flow processSignal.processedSignal to transmit.status;
        flow transmit.status to communicationLink.protocol; // Uses the CommPort to send data
    }
}
