package SmartHomeKitchenFunctionalAndLogicalArchitecture {

    private import SmartHomeKitchenPhysicalArchitecture::*;
    private import SmartHomeKitchen::*;

    // Functional Smart Home Kitchen Model
    part smartHomeKitchen : SmartHomeKitchen;

    part smartHomeKitchenSmall : SmartHomeKitchenSmall {
        part visionSensors : Sensors::Camera[2] :> foodDetectionCamera;

        // Action Usages for Small Kitchen Model
        perform action trackFoodInventory : TrackFoodInventory, EnergyEfficientAction {
            redefines cost = 0.3 [SI::W];
            redefines maxDuration = 500 [SI::s];
        }

        perform action suggestRecipes : SuggestRecipes;
    }

    part smartHomeKitchenLarge : SmartHomeKitchenLarge {
        part visionSensors : Sensors::Camera[3] :> foodDetectionCamera;

        // Action Usages for Large Kitchen Model
        perform action trackFoodInventory : TrackFoodInventory, EnergyEfficientAction {
            redefines cost = 0.6 [SI::W];
            redefines maxDuration = 700 [SI::s];
        }

        perform action suggestRecipes : SuggestRecipes;
    }

    // **Logical Decomposition of Food Tracking Process**
    action def TrackFoodInventory {
        action detectFoodItem : ComputerVisionSystem::DetectObjects {
            out item foodItemData;
        }

        action analyzeFoodItem : AnalyzeFoodItem {
            in item foodItemData = detectFoodItem.foodItemData;
            out item categorizedFoodData;
        }

        action updateInventory : UpdateInventory {
            in item categorizedFoodData = analyzeFoodItem.categorizedFoodData;
        }

        first detectFoodItem then analyzeFoodItem;
        first analyzeFoodItem then updateInventory;
    }

    // **Logical Decomposition of Recipe Suggestion Process**
    action def SuggestRecipes {
        action checkAvailableIngredients : CheckAvailableIngredients {
            out item availableIngredients;
        }

        action generateRecipe : GenerateRecipe {
            in item availableIngredients = checkAvailableIngredients.availableIngredients;
            out item recommendedRecipe;
        }

        action notifyUser : NotifyUser {
            in item recommendedRecipe = generateRecipe.recommendedRecipe;
        }

        first checkAvailableIngredients then generateRecipe;
        first generateRecipe then notifyUser;
    }

    // **Logical Decomposition of Notifications**
    action def SendKitchenNotifications {
        action detectLowStock : DetectLowStock {
            out item lowStockAlert;
        }

        action detectExpiringItems : DetectExpiringItems {
            out item expirationAlert;
        }

        action notifyUser : NotifyUser {
            in item alertData;
        }

        first detectLowStock then notifyUser;
        first detectExpiringItems then notifyUser;
    }

    // **Logical Decomposition of Smart Monitoring System**
    action def SmartKitchenMonitoring {
        action monitorTemperature : MonitorTemperature {
            out item tempReading;
        }

        action monitorFoodSpoilage : MonitorFoodSpoilage {
            in item tempReading = monitorTemperature.tempReading;
            out item spoilageAlert;
        }

        first monitorTemperature then monitorFoodSpoilage;
    }

    // **Energy Constraints for Actions**
    action def EnergyEfficientAction {
        attribute cost : ISQ::PowerValue;
    }

    // **Allocations of Functional Processes to Physical Components**
    allocate smartHomeKitchenSmall.trackFoodInventory to smartHomeKitchenSmall {
        allocate smartHomeKitchenSmall.trackFoodInventory.detectFoodItem to smartHomeKitchenSmall.foodDetectionCamera;
        allocate smartHomeKitchenSmall.trackFoodInventory.analyzeFoodItem to smartHomeKitchenSmall.centralProcessor;
        allocate smartHomeKitchenSmall.trackFoodInventory.updateInventory to smartHomeKitchenSmall.storageUnit;
    }

    allocate smartHomeKitchenSmall.suggestRecipes to smartHomeKitchenSmall {
        allocate smartHomeKitchenSmall.suggestRecipes.checkAvailableIngredients to smartHomeKitchenSmall.storageUnit;
        allocate smartHomeKitchenSmall.suggestRecipes.generateRecipe to smartHomeKitchenSmall.aiProcessor;
        allocate smartHomeKitchenSmall.suggestRecipes.notifyUser to smartHomeKitchenSmall.alertSystem;
    }

    allocate smartHomeKitchenSmall.sendKitchenNotifications to smartHomeKitchenSmall {
        allocate smartHomeKitchenSmall.sendKitchenNotifications.detectLowStock to smartHomeKitchenSmall.storageUnit;
        allocate smartHomeKitchenSmall.sendKitchenNotifications.detectExpiringItems to smartHomeKitchenSmall.storageUnit;
        allocate smartHomeKitchenSmall.sendKitchenNotifications.notifyUser to smartHomeKitchenSmall.alertSystem;
    }

    allocate smartHomeKitchenSmall.smartKitchenMonitoring to smartHomeKitchenSmall {
        allocate smartHomeKitchenSmall.smartKitchenMonitoring.monitorTemperature to smartHomeKitchenSmall.temperatureSensor;
        allocate smartHomeKitchenSmall.smartKitchenMonitoring.monitorFoodSpoilage to smartHomeKitchenSmall.centralProcessor;
    }

}
