package SmartHomeKitchenUseCases {

    part def SmartHomeKitchen;
    part def User;
    part def Ingredient;
    part def RecipeDatabase;
    part def NotificationSystem;

    // Primary Use Case: Managing the Smart Kitchen
    use case 'Manage Smart Kitchen' {
        subject kitchenSystem : SmartHomeKitchen;
        
        actor user : User;
        
        objective {
            doc 
            /* Ensure that the system efficiently tracks inventory, suggests recipes, 
             * and notifies users about stock status while maintaining an interactive experience.
             */
        }

        ref :>> start {
            doc /* System initialized and ready for user interaction */
            assert constraint {
                doc /* Kitchen System is online */
            }
        }

        first start;

        then include 'Track Inventory' {
            actor :>> user = 'Manage Smart Kitchen'::user;
        }

        then include 'Generate Recipe Suggestions' {
            actor :>> user = 'Manage Smart Kitchen'::user;
        }

        then include 'Send Notifications' {
            actor :>> user = 'Manage Smart Kitchen'::user;
        }

        then include 'Update Preferences' {
            actor :>> user = 'Manage Smart Kitchen'::user;
        }

        then done;

        ref :>> done {
            doc /* Kitchen system has provided required suggestions and updates */
            assert constraint {
                doc /* User has received recipe suggestions, stock alerts, and can update preferences */
            }
        }
    }

    // Use Case: Track Inventory
    use case 'Track Inventory' {
        subject kitchenSystem : SmartHomeKitchen;
        actor user : User;
        actor ingredient : Ingredient;
    }

    // Use Case: Generate Recipe Suggestions
    use case 'Generate Recipe Suggestions' {
        subject kitchenSystem : SmartHomeKitchen;
        actor user : User;
        actor recipeDatabase : RecipeDatabase;
    }

    // Use Case: Send Notifications
    use case 'Send Notifications' {
        subject kitchenSystem : SmartHomeKitchen;
        actor user : User;
        actor notificationSystem : NotificationSystem;
    }

    // Use Case: Update Preferences
    use case 'Update Preferences' {
        subject kitchenSystem : SmartHomeKitchen;
        actor user : User;
    }
}
