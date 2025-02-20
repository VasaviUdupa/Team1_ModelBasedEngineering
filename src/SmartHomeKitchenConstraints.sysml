package SmartHomeKitchenConstraints {

    private import ScalarValues::*;

    // Define Smart Kitchen System
    part def SmartKitchen {
        attribute mealCalories: Real;
        attribute maxCaloriesPerMeal: Real;
        attribute numPeople: Integer;
        attribute minPeople: Integer;
        attribute expirationThreshold: Real;
        attribute daysUntilExpiration: Real;
        attribute currentStock: Integer;
        attribute minStockLevel: Integer;
        attribute itemStock: Integer;
        attribute itemName: String;
    }

    // Define Smart Kitchen Analysis
    analysis def SmartKitchenAnalysis {
        subject kitchen : SmartKitchen;
        
        objective kitchenAnalysisObjective {
            /*
             * The objective of this analysis is to determine whether the
             * Smart Home Kitchen meets operational requirements.
             */

            assume constraint {
                kitchen.maxCaloriesPerMeal == 600 &
                kitchen.minPeople == 1 &
                kitchen.expirationThreshold == 3 &
                kitchen.minStockLevel == 2
            }

            require constraint {
                kitchen.mealCalories < kitchen.maxCaloriesPerMeal &
                kitchen.numPeople > kitchen.minPeople &
                kitchen.daysUntilExpiration > kitchen.expirationThreshold &
                kitchen.currentStock > kitchen.minStockLevel &
                kitchen.itemStock > kitchen.minStockLevel
            }
        }

        return kitchenStatus : Boolean = (
            kitchen.mealCalories < kitchen.maxCaloriesPerMeal &
            kitchen.numPeople > kitchen.minPeople &
            kitchen.daysUntilExpiration > kitchen.expirationThreshold &
            kitchen.currentStock > kitchen.minStockLevel &
            kitchen.itemStock > kitchen.minStockLevel
        );
    }
}
