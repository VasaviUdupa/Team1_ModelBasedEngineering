package SmartHomeKitchenUtilizationStateMachine {

    package Definitions {
        // Define Smart Home Kitchen Utilization State Machine
        part def SmartHomeKitchen {
            exhibit state 'utilization states': 'Utilization States';
        }

        // Define States
        state def 'Utilization States';

        // Define Actions
        action def 'Monitor Food Stock';
        action def 'Track Expiration Dates';
        action def 'Generate Meal Suggestions';
        action def 'User Reviews Recipe';
        action def 'User Cooks Meal';
        action def 'User Provides Feedback';
        action def 'System Learns Preferences';
        action def 'Notify Low Stock';
        action def 'Handle Errors';

        // Define Attributes
        attribute def 'Food Stock Updated';
        attribute def 'Expiration Dates Tracked';
        attribute def 'Meal Suggested';
        attribute def 'Recipe Reviewed';
        attribute def 'Meal Cooked';
        attribute def 'User Feedback Provided';
        attribute def 'User Preferences Updated';
        attribute def 'Low Stock Alert Sent';
        attribute def 'Processing Failed';
    }

    package Usages {
        private import Definitions::*;

        // Actions
        action 'monitor food stock': 'Monitor Food Stock';
        action 'track expiration': 'Track Expiration Dates';
        action 'generate meal': 'Generate Meal Suggestions';
        action 'review recipe': 'User Reviews Recipe';
        action 'cook meal': 'User Cooks Meal';
        action 'provide feedback': 'User Provides Feedback';
        action 'learn preferences': 'System Learns Preferences';
        action 'notify stock': 'Notify Low Stock';
        action 'handle errors': 'Handle Errors';

        // State Machine for Utilization Phase
        state 'utilization states' parallel {
            ref smartKitchen : SmartHomeKitchen;

            // Initial State
            state Start {
                entry action initial;
                transition initial then MonitorStock;
            }

            // Monitor Food Stock
            state MonitorStock {
                transition 'food-stock-updated'
                    first MonitorStock
                    accept 'Food Stock Updated'
                    do send 'Monitor Food Stock'() to smartKitchen
                    then TrackExpiration;
            }

            // Track Expiration Dates
            state TrackExpiration {
                transition 'expiration-tracked'
                    first TrackExpiration
                    accept 'Expiration Dates Tracked'
                    do send 'Track Expiration Dates'() to smartKitchen
                    then GenerateMeal;
            }

            // Generate Meal Suggestions
            state GenerateMeal {
                transition 'meal-suggested'
                    first GenerateMeal
                    accept 'Meal Suggested'
                    do send 'Generate Meal Suggestions'() to smartKitchen
                    then ReviewRecipe;
            }

            // User Reviews the Recipe
            state ReviewRecipe {
                transition 'recipe-reviewed'
                    first ReviewRecipe
                    accept 'Recipe Reviewed'
                    then CookMeal;
            }

            // User Cooks Meal
            state CookMeal {
                transition 'meal-cooked'
                    first CookMeal
                    accept 'Meal Cooked'
                    do send 'User Cooks Meal'() to smartKitchen
                    then ProvideFeedback;
            }

            // User Provides Feedback
            state ProvideFeedback {
                transition 'feedback-received'
                    first ProvideFeedback
                    accept 'User Feedback Provided'
                    do send 'User Provides Feedback'() to smartKitchen
                    then LearnPreferences;
            }

            // System Learns User Preferences
            state LearnPreferences {
                transition 'preferences-updated'
                    first LearnPreferences
                    accept 'User Preferences Updated'
                    do send 'System Learns Preferences'() to smartKitchen
                    then Pass;
            }

            // Notify User of Low Stock
            state NotifyStock {
                transition 'low-stock-alert'
                    first NotifyStock
                    accept 'Low Stock Alert Sent'
                    do send 'Notify Low Stock'() to smartKitchen
                    then Pass;
            }

            // Handle Errors
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
