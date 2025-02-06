package CameraSystem {

    private import ScalarValues::*;
    private import SI::*;

    // Define the Camera Component
    part def Camera {
        // Attributes defining the Camera hardware specifications
        attribute resolution: String;  // e.g., "1920x1080" (Full HD)
        attribute frameRate: Real;  // e.g., "30.0" (frames per second)
        attribute powerConsumption: Real; // e.g., "2.5" (watts)
        attribute sensorType: String; // e.g., "CMOS" or "CCD"
        attribute storageCapacity: Real; // e.g., "16GB"

        // Communication Ports
        port captureTrigger: Boolean; // Triggers image capture when food is placed
        port imageOutput: String; // Sends captured image to Computer Vision system

        // Define Behavior for Capturing Food Images
        behavior def CaptureFoodImage {
            parameter input triggerSignal: Boolean;  // Signal to capture image
            parameter output imageData: String;  // Captured image data

            action detectFoodPlacement;  // Detects food in the fridge
            action captureFrame;  // Takes an image
            action storeImage;  // Saves image to internal memory
            action sendImageData;  // Transmits image to Computer Vision

            control flow {
                detectFoodPlacement -> captureFrame;
                captureFrame -> storeImage;
                storeImage -> sendImageData;
            }
        }
    }
}
