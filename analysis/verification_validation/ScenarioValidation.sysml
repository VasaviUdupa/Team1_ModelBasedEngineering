package 'SmartHomeKitchenValidation' {

    part def SmartHomeKitchen;
    part def User;
    part def NotificationSystem;
    part def Database;
    part def ComputerVisionSystem;
    part def LLMSystem;

    use case 'Manage Inventory' {
        subject kitchenSystem : SmartHomeKitchen;
        actor user : User;

        objective {
            doc
            /* Ensure the system accurately tracks groceries and updates inventory */
        }

        ref :>> start {
            doc /* Precondition: User adds or removes groceries */
        }

        first start;

        then include 'Add Groceries' {
            actor :>> user = 'Manage Inventory'::user;
        }

        then use case 'Update Inventory' {
            include 'Detect Grocery Items' {
                actor :>> system = ComputerVisionSystem;
                ref :>> start {
                    doc /* Camera captures groceries and processes images */
                }
            }
        }

        then use case 'Trigger Expiry Notifications' {
            include 'Check Expiry Dates' {
                actor :>> system = Database;
                ref :>> start {
                    doc /* System compares current date with stored expiry dates */
                }
            }
        }

        then include 'Send Notification' {
            actor :>> notificationSystem = NotificationSystem;
            ref :>> start {
                doc /* If expired, user receives a notification */
            }
        }

        then done;

        ref :>> done {
            doc /* Postcondition: User is notified, inventory is updated */
        }
    }

    use case 'Add Groceries' {
        subject kitchenSystem : SmartHomeKitchen;
        actor user : User;
    }

    use case 'Update Inventory' {
        subject kitchenSystem : SmartHomeKitchen;
        actor system : ComputerVisionSystem;
    }

    use case 'Trigger Expiry Notifications' {
        subject kitchenSystem : SmartHomeKitchen;
        actor system : Database;
    }

    use case 'Send Notification' {
        subject kitchenSystem : SmartHomeKitchen;
        actor notificationSystem : NotificationSystem;
    }

    // Failure Scenario
    use case 'Failure - No Internet Connection' {
        subject kitchenSystem : SmartHomeKitchen;
        actor user : User;

        ref :>> failureStart {
            doc /* Precondition: User adds groceries, but system has no internet */
        }

        first failureStart;

        then use case 'System Cannot Sync' {
            actor :>> kitchenSystem;
            ref :>> start {
                doc /* System fails to update database */
            }
        }

        then include 'Retry Sync Later' {
            actor :>> kitchenSystem;
            ref :>> start {
                doc /* System stores offline data and retries after reconnection */
            }
        }

        then done;

        ref :>> failureDone {
            doc /* Postcondition: Inventory updates when reconnected */
        }
    }

    use case 'Retry Sync Later' {
        subject kitchenSystem : SmartHomeKitchen;
        actor system : Database;
    }

}
