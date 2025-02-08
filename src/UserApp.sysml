package SmartHomeKitchenComponents {

    import ScalarValues::*;
    import SI::*;

    // Define User Interface (UI)
    part def UserInterface {
        doc /* Interface for user interactions with the smart home kitchen system */

        // Attributes
        attribute displayType: String;  // e.g., "LCD", "Touch Screen"
        attribute resolution: String;  // e.g., "1920x1080"
        attribute interfaceType: String;  // e.g., "Graphical", "Voice-Activated"
        attribute touchSensitivity: Real;  // e.g., "5ms response"
        attribute userFeedback: String;  // e.g., "Haptic feedback", "Audio cues"

        // Ports
        port userInput: DataPort;  // Receives input from users
        port userOutput: DataPort; // Sends visual or audible data to users

        // Actions
        action DisplayInformation { in content: String; }
        action ReceiveInput { out command: String; }
        action UpdateDisplaySettings {}
        action ProvideFeedback { in feedbackType: String; }
    }
}
