package SmartHomeKitchenComponents {

    private import ScalarValues::*;
    private import SI::*;

    // Define Data Port
    port def DataPort {
        doc /* Interface for both input and output data */
        attribute dataFormat: String = "JSON"; // Standard data format for interoperability
        attribute transferRate: Real = 20; // Mbps, to handle rapid user interactions
    }

    // Define User Interface (UI)
    part def UserInterface {
        doc /* Interface for user interactions with the smart home kitchen system */

        // Attributes defining the UI characteristics
        attribute displayType: String = "Touch Screen"; // Specifies the type of display used
        attribute resolution: String = "1920x1080"; // High definition display resolution
        attribute interfaceType: String = "Graphical and Voice-Activated"; // Supports multiple interaction modes
        attribute touchSensitivity: Real = 5; // Response time in milliseconds
        attribute userFeedback: String = "Haptic feedback and Audio cues"; // Types of feedback provided to the user

        // Ports for user interaction
        port userInput: DataPort;  // Receives data from user interactions
        port userOutput: DataPort; // Sends data to users in response to interactions

        // Actions for managing UI operations
        action DisplayInformation { in content: String; }
        action ReceiveInput { out command: String; }
        action UpdateDisplaySettings { in newSettings: String; }
        action ProvideFeedback { in feedbackType: String; }

        // Flow for User Interface Operations
        action UIOperations {
            action displayInfo: DisplayInformation[1];
            action receiveInput: ReceiveInput[1];
            action updateSettings: UpdateDisplaySettings[1];
            action provideFeedback: ProvideFeedback[1];

            // Operational sequence
            flow receiveInput.command to displayInfo.content;
            flow receiveInput.command to updateSettings.newSettings;
            flow receiveInput.command to provideFeedback.feedbackType;

            // Direct feedback based on user inputs
            flow provideFeedback.feedbackType to userOutput.dataFormat;
        }
    }
}
