package SmartHomeKitchen {
    
    private import ScalarValues::*;
    private import CameraSystem::*;
    private import ComputerSystem::*;
    private import ComputerVisionSystem::*;
<<<<<<< HEAD
    private import DatabaseManagementSystem::*;
    private import SensorSystem::*;
    private import NotificationSystem::*;
    private import LLMSystem::*;
    private import UserInterface::*;
    private import Ingredient::*;
=======
    private import HardwareSystem::*;
>>>>>>> aa5c2f0 (update import packages)

    // Define the main Smart Home Kitchen system
    part def SmartHomeKitchen {
        attribute systemStatus: String;
        attribute totalPowerConsumption: Real; // Power usage in Watts
        attribute connectivityStatus: String; // "Online" or "Offline"
        
        // System Components
        part computerSystem: Computer;
        part cameraSystem: Camera;
        part computerVisionSystem: ComputerVision;
        part screen: UserInterface;
        part wiringHarness: WiringHarness;
        part refrigerator: Refrigerator;
        part powerSystem: PowerSystem;
        part llm: RecipeLLM;
        part database: DatabaseManagementSystem;
        part internetConnects: InternetConnects;
        part notificationSystem: NotificationSystem;
        part sensorSystem: DoorSensor;
    }

    // Define Essential Components

    part def WiringHarness {
        attribute voltageRating: Real; // Voltage capacity (V)
        attribute material: String; // e.g., "Copper"
    }

    part def Refrigerator {
        attribute temperature: Real; // Current temperature (°C)
        attribute doorStatus: Boolean; // True if open, False if closed
    }

    part def PowerSystem {
        attribute batteryBackup: Boolean;
        attribute powerRating: Real; // Max power (Watts)
    }

    part def InternetConnects {
        attribute connectionType: String; // e.g., "WiFi", "Ethernet"
        attribute bandwidth: Real; // Speed (Mbps)
    }

    // Define Actions for Smart Home Kitchen Workflow
    action def DetectFood { out detectedFood: Ingredient; }
    action def ProcessFoodData { in foodInput: Ingredient; out processedData: String; }
    action def GenerateRecipe { in foodData: String; out recipeSuggestion: String; }
    action def DisplayRecipe { in recipe: String; }
    action def MonitorStock { out lowStockItems: Ingredient[*]; }
    action def SendNotification { in alertData: String; }

    // Define Flow for Smart Kitchen System
    action SmartKitchenWorkflow {
        action detectFood: DetectFood[1];
        action processFood: ProcessFoodData[1];
        action generateRecipe: GenerateRecipe[1];
        action displayRecipe: DisplayRecipe[1];
        action monitorStock: MonitorStock[1];
        action sendNotification: SendNotification[1];

        flow detectFood.detectedFood to processFood.foodInput;
        flow processFood.processedData to generateRecipe.foodData;
        flow generateRecipe.recipeSuggestion to displayRecipe.recipe;
        flow monitorStock.lowStockItems to sendNotification.alertData;
    }
}
