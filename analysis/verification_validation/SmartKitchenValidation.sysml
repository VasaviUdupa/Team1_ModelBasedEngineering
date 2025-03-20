package SmartHomeKitchenValidation {

    part def SmartHomeKitchen;
    part def User;
    part def Environment;
    part def InternetService;
    
    use case 'Manage Kitchen Inventory' {
        subject kitchenSystem : SmartHomeKitchen;
        
        actor user : User;
        actor environment : Environment;
        actor cloudService : InternetService;

        objective {
            doc 
            /* Ensure users can manage inventory effectively by adding, removing, 
             * and updating groceries, and receiving correct notifications 
             * for low-stock and expired food items.
             */
        }

        ref :>> start {
            doc /* Pre-condition: User has logged into the system */
            assert constraint {
                doc /* System authentication is successful */
            }
        }

        first start;

        then include 'Add Items to Inventory' {
            actor :>> user = 'Manage Kitchen Inventory'::user;
        }

        then include 'Remove Items from Inventory' {
            actor :>> user = 'Manage Kitchen Inventory'::user;
        }

        then use case 'Update Inventory Database' {
            include 'Check Expiry Dates' {
                actor :>> environment = 'Manage Kitchen Inventory'::environment;
            }
            include 'Sync with Cloud'[0..*] {
                doc
                /*
                 * Ensures real-time synchronization with cloud services for 
                 * remote access and updates.
                 */
                actor :>> cloudService;
                ref :>> start {
                    doc /* Database connection is available */
                }
            }
        }

        then include 'Receive Notification Alerts' {
            actor :>> user = 'Manage Kitchen Inventory'::user;
        }

        then done;

        ref :>> done {
            doc /* Post-condition: User inventory is updated and notifications are sent */
            assert constraint {
                doc /* System correctly reflects inventory changes */
            }
        }
    }

    use case 'Add Items to Inventory' {
        subject kitchenSystem : SmartHomeKitchen;
        actor user : User;
    }

    use case 'Remove Items from Inventory' {
        subject kitchenSystem : SmartHomeKitchen;
        actor user : User;
    }
    
    use case 'Update Inventory Database' {
        subject kitchenSystem : SmartHomeKitchen;
        actor environment : Environment;
        actor cloudService : InternetService;
    }

    use case 'Check Expiry Dates' {
        subject kitchenSystem : SmartHomeKitchen;
        actor environment : Environment;
    }

    use case 'Sync with Cloud' {
        subject kitchenSystem : SmartHomeKitchen;
        actor cloudService : InternetService;
    }

    use case 'Receive Notification Alerts' {
        subject kitchenSystem : SmartHomeKitchen;
        actor user : User;
    }
}
