package CameraSystem {

    private import ScalarValues::*;
    private import SI::*;

    // Define Image Capture Port
    port def ImagePort {
        doc /* Image transmission interface */
        attribute imageFormat: String; // e.g., "JPEG", "PNG"
        attribute resolution: String; // e.g., "1920x1080"
        attribute frameRate: Real; // e.g., "30 FPS"
        attribute dataSize: Real; // e.g., "2.5MB per image"
    }

    // Define Network Port
    port def NetworkPort {
        doc /* Network interface for camera streaming */
        attribute protocol: String; // e.g., "WiFi", "Ethernet"
        attribute bandwidth: Real; // e.g., "50 Mbps"
        attribute connectionType: String; // e.g., "Wireless"
    }

    // Define Storage Port
    port def StoragePort {
        doc /* Camera storage system interface */
        attribute storageType: String; // e.g., "SD Card", "Cloud"
        attribute capacity: Real; // e.g., "128GB"
        attribute writeSpeed: Real; // e.g., "90MB/s"
    }

    // Define the Camera Component
    part def Camera {
        doc /* Camera module for capturing food images */

        // Attributes defining Camera hardware specifications
        attribute sensorType: String; // e.g., "CMOS" or "CCD"
        attribute resolution: String; // e.g., "4K"
        attribute frameRate: Real; // e.g., "30 FPS"
        attribute powerConsumption: Real; // e.g., "3W"

        // Communication Ports
        port imageOutput: ImagePort; // Sends captured images to Computer Vision
        port networkInterface: NetworkPort; // Sends data over the network
        port storageInterface: StoragePort; // Saves images locally or on cloud
    }
}
