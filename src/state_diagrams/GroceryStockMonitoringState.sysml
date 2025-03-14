package GroceryStockMonitoringState {

    package Definitions {
        // Define Test Components
        part def GroceryStockTest {
            perform action 'Check Stock': 'CheckGroceryStock';
            exhibit state 'grocery states': 'Grocery Stock States';
        }

        // Define Test States
        state def 'Grocery Stock States';

        // Define Actions
        action def 'CheckGroceryStock';
        action def 'UpdateInventory';
        action def 'TriggerRestockNotification';

        // Define Attributes
        attribute def 'Stock Updated';
        attribute def 'Low Stock Detected';
        attribute def 'Notification Sent';
        attribute def 'Processing Failed';
    }

    package Usages {
        private import Definitions::*;

        // Actions
        action 'check stock': 'CheckGroceryStock';
        action 'update inventory': 'UpdateInventory';
        action 'trigger restock': 'TriggerRestockNotification';

        // State Machine for Grocery Stock Monitoring
        state 'grocery states' {
            ref groceryMonitor : GroceryStockTest;

            state Start {
                entry action initial;
                transition initial then CheckStock;
            }

            state CheckStock {
                transition 'stock-verified'
                    first CheckStock
                    accept 'Stock Updated'
                    do send 'CheckGroceryStock'() to groceryMonitor
                    then UpdateInventory;

                transition 'low-stock'
                    first CheckStock
                    accept 'Low Stock Detected'
                    then TriggerRestockNotification;
            }

            state UpdateInventory {
                transition 'inventory-success'
                    first UpdateInventory
                    accept 'Stock Updated'
                    then Pass;

                transition 'update-fail'
                    first UpdateInventory
                    accept 'Processing Failed'
                    then Fail;
            }

            state TriggerRestockNotification {
                transition 'notification-sent'
                    first TriggerRestockNotification
                    accept 'Notification Sent'
                    then Pass;

                transition 'notification-fail'
                    first TriggerRestockNotification
                    accept 'Processing Failed'
                    then Fail;
            }

            state Pass {
                final;
            }

            state Fail {
                final;
            }
        }
    }
}
