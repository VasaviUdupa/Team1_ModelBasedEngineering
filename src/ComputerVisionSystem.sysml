package ComputerVisionSystem {

    private import ScalarValues::*;
    private import SI::*;

    // Define the Computer Vision Component
    part def ComputerVision {
        // Attributes defining the AI processing capabilities
        attribute modelType: String;  // e.g., "YOLOv5", "MobileNet"
        attribute accuracy: Real;  // e.g., 95.0 (%)
        attribute processingSpeed: Real; // e.g., 30.0 (frames per second)
        attribute powerConsumption: Real; // e.g., 5.0 (watts)

        // Communication Ports
        port imageInput: String;  // Receives images from Camera
        port detectionOutput: String; // Sends recognized food details to Computer

        // Define Behavior for Recognizing Food
        behavior def RecognizeFood {
            parameter input imageData: String;  // Image from Camera
            parameter output foodItems: String;  // Detected food list

            action receiveImage;  // Receive image input
            action preprocessImage;  // Apply filters, resize, etc.
            action detectObjects;  // Apply AI-based object detection
            action classifyFood;  // Identify specific food items
            action sendRecognitionData;  // Send detected results

            control flow {
                receiveImage -> preprocessImage;
                preprocessImage -> detectObjects;
                detectObjects -> classifyFood;
                classifyFood -> sendRecognitionData;
            }
        }
    }
}
