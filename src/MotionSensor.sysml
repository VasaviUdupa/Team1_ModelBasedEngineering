package SmartHomeKitchenComponents {

    import ScalarValues::*;
    import SI::*;

    // Define Motion Sensor
    part def MotionSensor {
        doc /* Detects motion within the kitchen to trigger automated tasks */

        // Attributes
        attribute sensitivityLevel: Real;  // e.g., "0.5" (low sensitivity) to "5" (high sensitivity)
        attribute detectionZone: String;  // e.g., "360-degree coverage"
        
        // Ports
        port motionDetected: DataPort;  // Outputs motion detection signal
        
        // Actions
        action DetectMotion {}
    }
}
