package RecipeRecommendationState {

    private import ScalarValues::*;

    package Definitions {
        // Define Test Components
        part def RecipeTest {
            perform action 'Generate Recipe': 'GenerateRecipe';
            exhibit state 'recipe states': 'Recipe Recommendation States';
        }

        // Define Test States
        state def 'Recipe Recommendation States';

        // Define Actions
        action def 'GenerateRecipe';
        action def 'ValidateRecipe';
        action def 'CheckDietaryRestrictions';

        // Define Attributes
        attribute def 'Recipe Generated';
        attribute def 'Recipe Validated';
        attribute def 'Dietary Compliant';
        attribute def 'Processing Failed';
    }

    package Usages {
        private import Definitions::*;

        // Actions
        action 'generate recipe': 'GenerateRecipe';
        action 'validate recipe': 'ValidateRecipe';
        action 'check dietary': 'CheckDietaryRestrictions';

        // State Machine for Recipe Recommendation
        state 'recipe states' {
            ref recipeEngine : RecipeTest;

            state Start {
                entry action initial;
                transition initial then GenerateRecipe;
            }

            state GenerateRecipe {
                transition 'recipe-created'
                    first GenerateRecipe
                    accept 'Recipe Generated'
                    do send 'GenerateRecipe'() to recipeEngine
                    then ValidateRecipe;

                transition 'recipe-fail'
                    first GenerateRecipe
                    accept 'Processing Failed'
                    then Fail;
            }

            state ValidateRecipe {
                transition 'recipe-valid'
                    first ValidateRecipe
                    accept 'Recipe Validated'
                    then CheckDietaryRestrictions;
            }

            state CheckDietaryRestrictions {
                transition 'dietary-pass'
                    first CheckDietaryRestrictions
                    accept 'Dietary Compliant'
                    then Pass;

                transition 'dietary-fail'
                    first CheckDietaryRestrictions
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
