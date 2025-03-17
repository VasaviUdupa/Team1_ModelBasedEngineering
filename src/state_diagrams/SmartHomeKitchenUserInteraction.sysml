package SmartHomeKitchenUserInteractionStateMachine {

    package Definitions {
        // Define Smart Home Kitchen State Machine
        part def SmartHomeKitchen {
            exhibit state 'user interaction states': 'User Interaction States';
        }

        // Define States
        state def 'User Interaction States';

        // Define Actions
        action def 'Start Interaction';
        action def 'Detect Food';
        action def 'Process Food Data';
        action def 'Apply Dietary Restrictions';
        action def 'Suggest Recipes';
        action def 'User Modifies Recipe';
        action def 'Confirm Final Recipe';
        action def 'User Provides Feedback';
        action def 'Notify User';
        action def 'Handle Errors';

        // Define Attributes
        attribute def 'User Initiates Interaction';
        attribute def 'Food Item Detected';
        attribute def 'Food Data Processed';
        attribute def 'Dietary Restrictions Applied';
        attribute def 'Recipe Suggested';
        attribute def 'User Modified Recipe';
        attribute def 'Recipe Confirmed';
        attribute def 'User Feedback Provided';
        attribute def 'Notification Sent';
        attribute def 'Processing Failed';
    }

    package Usages {
        private import Definitions::*;

        // Actions
        action 'start interaction': 'Start Interaction';
        action 'detect food': 'Detect Food';
        action 'process food data': 'Process Food Data';
        action 'apply dietary restrictions': 'Apply Dietary Restrictions';
        action 'suggest recipes': 'Suggest Recipes';
        action 'user modifies recipe': 'User Modifies Recipe';
        action 'confirm final recipe': 'Confirm Final Recipe';
        action 'user provides feedback': 'User Provides Feedback';
        action 'notify user': 'Notify User';
        action 'handle errors': 'Handle Errors';

        // State Machine for User Interaction Workflow
        state 'user interaction states' parallel {
            ref smartKitchen : SmartHomeKitchen;

            // Initial State
            state Start {
                entry action initial;
                transition initial then UserInitiates;
            }

            // User initiates interaction
            state UserInitiates {
                transition 'interaction-started'
                    first UserInitiates
                    accept 'User Initiates Interaction'
                    do send 'Start Interaction'() to smartKitchen
                    then DetectFood;
            }

            // Detect food placement
            state DetectFood {
                transition 'food-detected'
                    first DetectFood
                    accept 'Food Item Detected'
                    do send 'Detect Food'() to smartKitchen
                    then ProcessFoodData;

                transition 'detection-failed'
                    first DetectFood
                    accept 'Processing Failed'
                    then HandleErrors;
            }

            // Process food data
            state ProcessFoodData {
                transition 'food-processed'
                    first ProcessFoodData
                    accept 'Food Data Processed'
                    do send 'Process Food Data'() to smartKitchen
                    then ApplyDietaryRestrictions;

                transition 'processing-failed'
                    first ProcessFoodData
                    accept 'Processing Failed'
                    then HandleErrors;
            }

            // Apply dietary restrictions before suggesting recipes
            state ApplyDietaryRestrictions {
                transition 'restrictions-applied'
                    first ApplyDietaryRestrictions
                    accept 'Dietary Restrictions Applied'
                    do send 'Apply Dietary Restrictions'() to smartKitchen
                    then SuggestRecipes;
            }

            // Suggest meal recipes
            state SuggestRecipes {
                transition 'recipe-suggested'
                    first SuggestRecipes
                    accept 'Recipe Suggested'
                    do send 'Suggest Recipes'() to smartKitchen
                    then UserModifiesRecipe;
            }

            // User modifies or confirms recipe
            state UserModifiesRecipe {
                transition 'recipe-modified'
                    first UserModifiesRecipe
                    accept 'User Modified Recipe'
                    then ConfirmFinalRecipe;

                transition 'no-modification'
                    first UserModifiesRecipe
                    accept 'Recipe Confirmed'
                    then NotifyUser;
            }

            // User confirms final recipe
            state ConfirmFinalRecipe {
                transition 'recipe-finalized'
                    first ConfirmFinalRecipe
                    accept 'Recipe Confirmed'
                    do send 'Confirm Final Recipe'() to smartKitchen
                    then NotifyUser;
            }

            // Notify the user
            state NotifyUser {
                transition 'notification-sent'
                    first NotifyUser
                    accept 'Notification Sent'
                    do send 'Notify User'() to smartKitchen
                    then UserProvidesFeedback;
            }

            // User provides feedback on the recipe or system performance
            state UserProvidesFeedback {
                transition 'feedback-received'
                    first UserProvidesFeedback
                    accept 'User Feedback Provided'
                    do send 'User Provides Feedback'() to smartKitchen
                    then Pass;
            }

            // Handle failures
            state HandleErrors {
                transition 'error-handled'
                    first HandleErrors
                    do send 'Handle Errors'() to smartKitchen
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
