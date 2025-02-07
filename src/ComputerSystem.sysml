package ComputerSystem {

    private import ScalarValues::*;
    private import SI::*;

    // Define Data Port
    port def DataPort {
        doc /* Data communication port definition */
        attribute dataType: String;  // e.g., "JSON", "Raw Image", "Text"
        attribute dataSize: Real;  // e.g., "2.5MB"
        attribute transferRate: Real;  // e.g., "10 Mbps"
    }

    // Define Network Port
    port def NetworkPort {
        doc /* Network communication port definition */
        attribute protocol: String;  // e.g., "WiFi", "Ethernet", "Bluetooth"
        attribute bandwidth: Real;  // e.g., "100 Mbps"
        attribute connectionType: String;  // e.g., "Wired/Wireless"
    }

    // Define Storage Port
    port def StoragePort {
        doc /* Storage interface port definition */
        attribute storageType: String;  // e.g., "Local SSD", "Cloud Storage"
        attribute capacity: Real;  // e.g., "500GB"
        attribute readWriteSpeed: Real;  // e.g., "500MB/s"
    }

    // Define Service Port
    port def ServicePort {
        doc /* Service definition for external communication */
        attribute serviceDefinition: String;  // e.g., "API Endpoint for Data Transfer"
        attribute serviceURL: String;  // e.g., "https://api.smartkitchen.com"
        attribute interfaceProtocol: String;  // e.g., "REST", "MQTT", "gRPC"
    }

    // Define the Computer Component
    part def Computer {
        doc /* Smart Home Kitchen Computer - Core processing unit */

        // Attributes defining the Computer hardware specifications
        attribute processorType: String;  // e.g., "ARM Cortex-A72"
        attribute ramSize: Real;  // e.g., "8GB"
        attribute storageCapacity: Real; // e.g., "256GB SSD"
        attribute connectivity: String;  // WiFi, Bluetooth, Ethernet
        attribute powerConsumption: Real; // e.g., "15W"
        attribute bootTime: Real; // e.g., "10s"

        // Communication Ports
        port inputData: DataPort;  // Receives data from Camera & Sensors
        port outputData: DataPort; // Sends processed data to other components
        port cameraInterface: DataPort;  // Interface to receive images from Camera
        port networkInterface: NetworkPort; // Interface for internet/cloud connectivity
        port storageInterface: StoragePort; // Interface for local/external storage
        port serviceInterface: ServicePort; // API interface for external services
    }

    // Define Actions for Computer Processing Workflow
    action def ReceiveData { out rawData: String; }
    action def ValidateData { in rawInput: String; out validatedData: String; }
    action def ProcessInformation { in validatedData: String; out processedOutput: String; }
    action def StoreData { in processedData: String; }
    action def SendOutput { in finalData: String; }

    // Define Flow for Data Processing in Computer
    action ComputerProcessingWorkflow {
        action receiveData: ReceiveData[1];
        action validateData: ValidateData[1];
        action processInfo: ProcessInformation[1];
        action storeData: StoreData[1];
        action sendOutput: SendOutput[1];

        flow receiveData.rawData to validateData.rawInput;
        flow validateData.validatedData to processInfo.validatedData;
        flow processInfo.processedOutput to storeData.processedData;
        flow processInfo.processedOutput to sendOutput.finalData;
    }
}
