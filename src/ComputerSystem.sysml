package ComputerSystem {

    private import ScalarValues::*;
    private import SI::*;

    // Define Port Types
    port def DataPort {
        attribute dataType: String; // e.g., "JSON", "Raw Image", "Text"
    }

    port def NetworkPort {
        attribute protocol: String; // e.g., "WiFi", "Ethernet", "Bluetooth"
    }

    port def StoragePort {
        attribute storageType: String; // e.g., "Local SSD", "Cloud Storage"
    }

    // Define the Computer Component
    part def Computer {
        // Attributes defining the Computer hardware specifications
        attribute processorType: String;  // e.g., "ARM Cortex-A72"
        attribute ramSize: Real;  // e.g., "8GB"
        attribute storageCapacity: Real; // e.g., "256GB SSD"
        attribute connectivity: String;  // WiFi, Bluetooth, Ethernet
        attribute powerConsumption: Real; // e.g., "15W"
        attribute bootTime: Real; // e.g., "10s"

        // Communication Ports (Now Using Proper Port Definitions)
        port inputData: DataPort;  // Receives data from camera & sensors
        port outputData: DataPort; // Sends processed data to other components
        port cameraInterface: DataPort;  // Interface to receive images from Camera
        port networkInterface: NetworkPort; // Interface for internet/cloud connectivity
        port storageInterface: StoragePort; // Interface for local or external storage
    }
}
