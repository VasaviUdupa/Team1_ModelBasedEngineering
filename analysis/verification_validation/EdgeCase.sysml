package SmartHomeKitchenValidation {

    private import ScalarValues::*;
    
    // Define the Smart Home Kitchen System
    part def SmartHomeKitchen {
        attribute systemStatus: String;
        attribute detectedFood: Boolean;
        attribute databaseUpdated: Boolean;
        attribute recipeGenerated: Boolean;
        attribute notificationSent: Boolean;
        attribute userFeedbackReceived: Boolean;
        attribute networkAvailable: Boolean;
    }

    // Define Actors for User Validation
    part def User;
    part def RemoteUser;
    part def NetworkService;
    part def KitchenDatabase;
    
    // Define Edge Case Scenarios
    use case def EdgeCaseValidation {
        subject kitchen: SmartHomeKitchen;

        action 'food detection failure' {
            in foodDetected: Boolean;
            out requestManualLabeling: Boolean;
        }

        action 'network failure' {
            in networkAvailable: Boolean;
            out alertQueued: Boolean;
        }

        action 'database error' {
            in databaseUpdated: Boolean;
            out retryUpdate: Boolean;
        }

        action 'notification failure' {
            in notificationSent: Boolean;
            out retryNotification: Boolean;
        }

        flow 'food detection failure'.foodDetected to 'food detection failure'.requestManualLabeling;
        flow 'network failure'.networkAvailable to 'network failure'.alertQueued;
        flow 'database error'.databaseUpdated to 'database error'.retryUpdate;
        flow 'notification failure'.notificationSent to 'notification failure'.retryNotification;
    }

    // Define User-Centered Validation Scenarios
    use case def UserCenteredValidation {
        subject kitchen: SmartHomeKitchen;
        actor user: User;
        actor remoteUser: RemoteUser;
        actor network: NetworkService;

        action 'user feedback on recipe' {
            in userFeedbackReceived: Boolean;
            out adjustRecipeSuggestion: Boolean;
        }

        action 'remote access' {
            in networkAvailable: Boolean;
            out kitchenAccessible: Boolean;
        }

        flow 'user feedback on recipe'.userFeedbackReceived to 'user feedback on recipe'.adjustRecipeSuggestion;
        flow 'remote access'.networkAvailable to 'remote access'.kitchenAccessible;
    }

    // Define Validation Cases
    validation def ValidateSmartKitchen {
        objective validationObjective {
            verify scenario edgeCaseScenario: EdgeCaseValidation;
            verify scenario userCenteredScenario: UserCenteredValidation;
        }
    }
}
