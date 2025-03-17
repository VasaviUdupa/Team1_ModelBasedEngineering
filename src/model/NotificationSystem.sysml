package NotificationSystem {

    private import ScalarValues::*;
    private import SI::*;
    
    // Define the Notification Port
    port def NotificationPort {
        doc /* Interface for sending notifications */
        attribute messageType: String; // e.g., "Low Stock Alert", "Expiration Alert", "Meal Suggestion"
        attribute messageContent: String;
        attribute priorityLevel: String; // e.g., "High", "Medium", "Low"
        attribute timestamp: TimeValue;
    }

    // Define the User Interface Port
    port def UserInterfacePort {
        doc /* Interface for user interaction */
        attribute interactionType: String; // e.g., "Push Notification", "SMS", "Email"
        attribute userResponse: String; // e.g., "Acknowledged", "Ignored"
    }

    // Define the Notification System Component
    part def NotificationSystem {
        doc /* System responsible for sending notifications to the user */

        // Attributes
        attribute systemStatus: String; // "Active" or "Inactive"
        attribute notificationQueue: Integer; // Number of pending notifications
        attribute maxNotifications: Integer default 100;

        // Communication Ports
        port notificationOutput: NotificationPort; // Sends notifications to the user
        port userInterface: UserInterfacePort; // Connects to user response system
    }

    // Define Actions for Notification Workflow
    action def DetectEvent { out eventType: String; }
    action def GenerateNotification { in eventType: String; out notificationMessage: String; }
    action def SendNotification { in notificationMessage: String; }
    action def ReceiveUserResponse { out userResponse: String; }

    // Define Flow for Notification System
    action NotificationWorkflow {
        action detectEvent: DetectEvent[1];
        action generateNotification: GenerateNotification[1];
        action sendNotification: SendNotification[1];
        action receiveUserResponse: ReceiveUserResponse[1];

        flow detectEvent.eventType to generateNotification.eventType;
        flow generateNotification.notificationMessage to sendNotification.notificationMessage;
        flow sendNotification.notificationMessage to receiveUserResponse.userResponse;
    }
}
