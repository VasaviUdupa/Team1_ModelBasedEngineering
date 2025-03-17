package SmartHomeKitchenVerificationStandalone {
	
	private import ScalarValues::*;
	private import Definitions::*;
	private import Usages::*;
	public import VerificationCases::*;
    public import VerificationSystem::*;

    package Definitions {

        // Define System Components for Verification
        part def SmartHomeKitchen {
            attribute systemStatus: String;
            attribute detectedFood: Boolean;
            attribute databaseUpdated: Boolean;
            attribute recipeGenerated: Boolean;
            attribute notificationSent: Boolean;
        }

        // Define Requirement Definitions
        requirement def FoodTrackingRequirement {
            attribute detectedFood : Boolean;
            attribute databaseUpdated : Boolean;

            doc /* The system shall correctly detect food items and update the database. */

            require constraint { detectedFood == true & databaseUpdated == true }
        }

        requirement def RecipeGenerationRequirement {
            attribute recipeGenerated : Boolean;

            doc /* The system shall generate a valid recipe based on detected food. */

            require constraint { recipeGenerated == true }
        }

        requirement def NotificationRequirement {
            attribute notificationSent : Boolean;

            doc /* The system shall notify users about low stock and expired food. */

            require constraint { notificationSent == true }
        }

        // Define Verification System
        part def VerificationSystem;
        part def SensorModule;
        part def TestOperator;
        part def FoodDatabase;

        // Define Instances for Testing
        individual def TestKitchen :> SmartHomeKitchen;
        individual def TestVerificationSystem :> VerificationSystem;

        // Define Verification for Food Tracking
        verification def VerifyFoodTracking {
            objective foodTrackingObjective {
                verify requirement trackingRequirement : FoodTrackingRequirement;
            }
        }

        // Define Verification for Recipe Generation
        verification def VerifyRecipeGeneration {
            objective recipeGenerationObjective {
                verify requirement recipeRequirement : RecipeGenerationRequirement;
            }
        }

        // Define Verification for Notification System
        verification def VerifyNotification {
            objective notificationObjective {
                verify requirement notificationRequirement : NotificationRequirement;
            }
        }
    }

    package Usages {

        // Requirement Instances
        requirement foodTrackingReq : FoodTrackingRequirement {
            subject kitchenSystem : SmartHomeKitchen;

            :>> detectedFood = kitchenSystem.detectedFood;
            :>> databaseUpdated = kitchenSystem.databaseUpdated;
        }

        requirement recipeGenReq : RecipeGenerationRequirement {
            subject kitchenSystem : SmartHomeKitchen;

            :>> recipeGenerated = kitchenSystem.recipeGenerated;
        }

        requirement notificationReq : NotificationRequirement {
            subject kitchenSystem : SmartHomeKitchen;

            :>> notificationSent = kitchenSystem.notificationSent;
        }

        // Verification Instances
        verification foodTrackingTest : VerifyFoodTracking {
            subject testKitchen : SmartHomeKitchen;

            objective foodTrackingObjective {
                verify foodTrackingReq :>> trackingRequirement;
            }

            action collectData {
                in part testKitchen : SmartHomeKitchen = foodTrackingTest.testKitchen;
                out foodDetected : Boolean;
            }

            action processData {
                in foodDetected : Boolean = collectData.foodDetected;
                out databaseUpdated : Boolean;
            }

            action evaluateData {
                in databaseUpdated : Boolean = processData.databaseUpdated;
                out verdict : VerdictKind = PassIf(foodTrackingReq(kitchenSystem = testKitchen(detectedFood = processData.foodDetected, databaseUpdated = databaseUpdated)));
            }

            return verdict : VerdictKind = evaluateData.verdict;
        }

        verification recipeGenTest : VerifyRecipeGeneration {
            subject testKitchen : SmartHomeKitchen;

            objective recipeGenerationObjective {
                verify recipeGenReq :>> recipeRequirement;
            }

            action collectData {
                in part testKitchen : SmartHomeKitchen = recipeGenTest.testKitchen;
                out recipeGenerated : Boolean;
            }

            action evaluateData {
                in recipeGenerated : Boolean = collectData.recipeGenerated;
                out verdict : VerdictKind = PassIf(recipeGenReq(kitchenSystem = testKitchen(recipeGenerated = recipeGenerated)));
            }

            return verdict : VerdictKind = evaluateData.verdict;
        }

        verification notificationTest : VerifyNotification {
            subject testKitchen : SmartHomeKitchen;

            objective notificationObjective {
                verify notificationReq :>> notificationRequirement;
            }

            action collectData {
                in part testKitchen : SmartHomeKitchen = notificationTest.testKitchen;
                out notificationSent : Boolean;
            }

            action evaluateData {
                in notificationSent : Boolean = collectData.notificationSent;
                out verdict : VerdictKind = PassIf(notificationReq(kitchenSystem = testKitchen(notificationSent = notificationSent)));
            }

            return verdict : VerdictKind = evaluateData.verdict;
        }

        // Define Test System Setup
        part verificationSystem : VerificationSystem {
            perform foodTrackingTest {
                in part :>> testKitchen = kitchenUnderTest;
            }

            perform recipeGenTest {
                in part :>> testKitchen = kitchenUnderTest;
            }

            perform notificationTest {
                in part :>> testKitchen = kitchenUnderTest;
            }

            ref part kitchenUnderTest : SmartHomeKitchen;

            part testOperator : TestOperator;
            part sensorModule : SensorModule;
        }

        // Individual Test Runs
        individual testSystem : TestVerificationSystem :> verificationSystem {
            timeslice test1 {
                ref individual :>> kitchenUnderTest : TestKitchen {
                    :>> detectedFood = true;
                    :>> databaseUpdated = true;
                    :>> recipeGenerated = true;
                    :>> notificationSent = true;
                }
            }
        }
    }
}
