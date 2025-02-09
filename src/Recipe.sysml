package Recipe {
    private import Ingredient::*;
    
    // Abstract action of the recipe, to be redifined by LLM
    abstract action def PrepareIngredients {in rawIngredients : Ingredient [*]; out prepedIngredients : Ingredient [*];}
    abstract action def CookIngredients {in prepedIngredients : Ingredient [*]; out cookedIngredients : Ingredient [*];}
    abstract action def PrepareMeal {in cookedIngredients : Ingredient [*]; out completedMeal : Ingredient;}
   
   	// Define the flow of the food from raw ingridients to meal 
	action RecipeFoodFlow {
   		action prepareIngredients: PrepareIngredients {in rawIngredients; out prepedIngredients;}
   		action cookIngredients: CookIngredients {in prepedIngredients; out cookedIngredients;}
   		action prepareMeal: PrepareMeal {in cookedIngredients; out completedMeal;}
		flow from prepareIngredients.prepedIngredients to cookIngredients.prepedIngredients;
		flow from cookIngredients.cookedIngredients to prepareMeal.cookedIngredients;
   	}
 }
    