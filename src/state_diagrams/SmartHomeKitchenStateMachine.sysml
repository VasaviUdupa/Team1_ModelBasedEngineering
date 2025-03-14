package SmartHomeKitchenStateMachine {

    package Definitions {
        // Define Smart Home Kitchen State Machine
        part def SmartHomeKitchen {
            exhibit state 'kitchen states': 'Smart Home Kitchen States';
        }

        // Define States
        state def 'Smart Home Kitchen States';

        // Define Actions
        action def 'Detect Motion';
        action def 'Capture Image';
        action def 'Process Image';
        action def 'Track Inventory';
        action def 'Detect Stock Levels';
        action def 'Generate Recipe';
        action def 'Check Dietary Restrictions';
        action def 'Notify User';
        action def 'Update Inventory Database';

        // Define Attributes
        attribute def 'Motion Detected';
        attribute def 'Image Captured';
        attribute def 'Object Identified';
        attribute def 'Stock Updated';
        attribute def 'Low Stock Detected';
        attribute def 'Inventory Updated';
        attribute def 'Recipe Generated';
        attribute def 'Dietary Compliant';
        attribute def 'Notification Sent';
        attribute def 'Processing Failed';
    }

    package Usages {
        private import Definitions::*;

        // Actions
        action 'detect motion': 'Detect Motion';
        action 'capture image': 'Capture Image';
        action 'process image': 'Process Image';
        action 'track inventory': 'Track Inventory';
        action 'detect stock': 'Detect Stock Levels';
        action 'update inventory': 'Update Inventory Database';
        action 'generate recipe': 'Generate Recipe';
        action 'check dietary': 'Check Dietary Restrictions';
        action 'notify user': 'Notify User';

        // State Machine for Smart Home Kitchen Workflow
        state 'kitchen states' parallel {
            ref smartKitchen : SmartHomeKitchen;

            // Start state
            state Start {
                entry action initial;
                transition initial then DetectMotion;
            }

            // Motion detection
            state DetectMotion {
                transition 'motion-detected'
                    first DetectMotion
                    accept 'Motion Detected'
                    do send 'Detect Motion'() to smartKitchen
                    then CaptureImage;

                transition 'motion-fail'
                    first DetectMotion
                    accept 'Processing Failed'
                    then Fail;
            }

            // Camera captures image
            state CaptureImage {
                transition 'image-captured'
                    first CaptureImage
                    accept 'Image Captured'
                    do send 'Capture Image'() to smartKitchen
                    then ProcessImage;
            }

            // Process image with computer vision
            state ProcessImage {
                transition 'object-identified'
                    first ProcessImage
                    accept 'Object Identified'
                    do send 'Process Image'() to smartKitchen
                    then TrackInventory;

                transition 'processing-fail'
                    first ProcessImage
                    accept 'Processing Failed'
                    then Fail;
            }

            // Inventory tracking and stock detection
            state TrackInventory {
                transition 'inventory-updated'
                    first TrackInventory
                    accept 'Inventory Updated'
                    do send 'Track Inventory'() to smartKitchen
                    then DetectStockLevels;
            }

            // Detect stock levels
            state DetectStockLevels {
                transition 'low-stock-detected'
                    first DetectStockLevels
                    accept 'Low Stock Detected'
                    then NotifyUser;

                transition 'stock-sufficient'
                    first DetectStockLevels
                    accept 'Stock Updated'
                    then GenerateRecipe;
            }

            // Recipe recommendation system
            state GenerateRecipe {
                transition 'recipe-created'
                    first GenerateRecipe
                    accept 'Recipe Generated'
                    do send 'Generate Recipe'() to smartKitchen
                    then CheckDietaryRestrictions;
            }

            // Check dietary compliance
            state CheckDietaryRestrictions {
                transition 'dietary-pass'
                    first CheckDietaryRestrictions
                    accept 'Dietary Compliant'
                    then NotifyUser;

                transition 'dietary-fail'
                    first CheckDietaryRestrictions
                    accept 'Processing Failed'
                    then Fail;
            }

            // User notification state
            state NotifyUser {
                transition 'notification-sent'
                    first NotifyUser
                    accept 'Notification Sent'
                    do send 'Notify User'() to smartKitchen
                    then UpdateInventoryDatabase;
            }

            // Update inventory database after notifications
            state UpdateInventoryDatabase {
                transition 'inventory-saved'
                    first UpdateInventoryDatabase
                    accept 'Inventory Updated'
                    then Pass;

                transition 'update-fail'
                    first UpdateInventoryDatabase
                    accept 'Processing Failed'
                    then Fail;
            }

            // Final states
            state Pass {
                final;
            }

            state Fail {
                final;
            }
        }
    }
}
