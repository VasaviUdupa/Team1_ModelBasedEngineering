package ComputerVisionSystem {

    private import ScalarValues::*;
    private import SI::*;

    // Define Image Processing Port
    port def ImageProcessingPort {
        doc /* Image processing input */
        attribute imageFormat: String; // e.g., "JPEG", "PNG"
        attribute resolution: String; // e.g., "1920x1080"
        attribute processingSpeed: Real; // e.g., "50 FPS"
        attribute recognitionAccuracy: Real; // e.g., "95%"
    }

    // Define Data Output Port
    port def DataOutputPort {
        doc /* Processed data output */
        attribute dataFormat: String; // e.g., "JSON", "XML"
        attribute transferRate: Real; // e.g., "20 Mbps"
    }

    // Define Network Port
    port def NetworkPort {
        doc /* Network interface for AI model updates */
        attribute protocol: String; // e.g., "WiFi", "Ethernet"
        attribute bandwidth: Real; // e.g., "100 Mbps"
    }

    // Define the Computer Vision Component
    part def ComputerVision {
        doc /* AI-based Computer Vision module for object detection */

        // Attributes defining AI processing specifications
        attribute modelType: String; // e.g., "YOLOv5", "MobileNet"
        attribute accuracy: Real; // e.g., "95%"
        attribute processingSpeed: Real; // e.g., "50 FPS"
        attribute powerConsumption: Real; // e.g., "5W"

        // Communication Ports
        port imageInput: ImageProcessingPort; // Receives images from Camera
        port detectionOutput: DataOutputPort; // Sends processed food recognition data
        port networkInterface: NetworkPort; // Connects to cloud or database for AI updates
    }

    // Define Actions for Image Processing Workflow
    action def ReceiveImage { out rawImage: String; }
    action def PreprocessImage { in imageData: String; out cleanedImage: String; }
    action def DetectObjects { in processedImage: String; out objectData: String; }
    action def ClassifyFood { in detectedObjects: String; out classifiedFood: String; }
    action def SendRecognitionData { in foodData: String; }

    // Define Flow for Computer Vision Processing
    action ComputerVisionProcessingWorkflow {
        action receiveImage: ReceiveImage[1];
        action preprocessImage: PreprocessImage[1];
        action detectObjects: DetectObjects[1];
        action classifyFood: ClassifyFood[1];
        action sendData: SendRecognitionData[1];

        flow receiveImage.rawImage to preprocessImage.imageData;
        flow preprocessImage.cleanedImage to detectObjects.processedImage;
        flow detectObjects.objectData to classifyFood.detectedObjects;
        flow classifyFood.classifiedFood to sendData.foodData;
    }
}
