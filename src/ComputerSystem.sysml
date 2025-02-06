package ComputerSystem {
	private import ScalarValues::*;
	private import SI::*;
	private import Quantities::*;
	private import MeasurementReferences::*;
	private import ISQ::*;
    private import BaseFunctions::ToString;
	private import ControlFunctions::*;
	private import ScalarFunctions::*;

    // Define the Computer Component
    part Computer {
        // Attributes defining the Computer hardware specifications
        attribute processorType: String;  // e.g., "ARM Cortex-A72"
        attribute ramSize: String;  // e.g., "8GB LPDDR4"
        attribute storageCapacity: String; // e.g., "256GB SSD"
        attribute connectivity: String;  // WiFi, Bluetooth, Ethernet
        attribute powerConsumption: String; // e.g., "15W"

        // Communication Ports
        port inputData: String;  // Receives data from camera & sensors
        port outputData: String; // Sends processed data to other components

        // Internal Interfaces
        port cameraInterface: String;  // Interface to receive images from Camera
        port networkInterface: String; // Interface for internet/cloud connectivity
        port storageInterface: String; // Interface for local or external storage

        // Define Behavior for Processing Data
        behavior ProcessData {
            parameter input rawData: String;  // Input from camera or other sources
            parameter output processedData: String;  // Processed information

            action receiveData;  // Receive raw input data
            action validateData;  // Validate incoming data
            action processInformation;  // Apply computation (AI, ML, Filtering)
            action storeData;  // Save processed data in local or cloud storage
            action sendOutput;  // Send processed data to the next component

            control flow {
                receiveData -> validateData;
                validateData -> processInformation;
                processInformation -> storeData;
                storeData -> sendOutput;
            }
        }

        // Define Power Management Behavior
        behavior PowerManagement {
            action monitorUsage;  // Check CPU/GPU load
            action optimizePerformance;  // Adjust performance based on load
            action manageTemperature;  // Prevent overheating

            control flow {
                monitorUsage -> optimizePerformance;
                optimizePerformance -> manageTemperature;
            }
        }

        // Define Networking Behavior
        behavior NetworkCommunication {
            parameter input requestData: String;
            parameter output responseData: String;

            action establishConnection;  // Open connection to cloud or local network
            action sendData;  // Transmit processed data
            action receiveResponse;  // Get acknowledgment or additional data

            control flow {
                establishConnection -> sendData;
                sendData -> receiveResponse;
            }
        }
    }
}
