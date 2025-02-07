package Recipe {
    private import Ingredient::*;
    
    action def PrepareIngredients { 
    	in rawIngredients : Ingredient [*]; 
    	out prepedIngredients : Ingredient [*]; 
    }
    action def CookIngredients { 
    	in prepedIngredients : Ingredient [*]; 
    	out cookedIngredients : Ingredient [*]; 
    }
    action def PrepareMeal { 
    	in cookedIngredients : Ingredient [*]; 
    	out completedMeal : Ingredient; 
    }
   
   	action prepareIngredients: PrepareIngredients {
   		in item rawIngredients;
   		out item prepedIngredients;
   	}
   	
   	flow from prepareIngredients.prepedIngredients to cookIngredients.prepedIngredients;
   	
   	action cookIngredients: CookIngredients {
   		in item prepedIngredients;
   		out item cookedIngredients;
   	}
   	
   	flow from cookIngredients.cookedIngredients to prepareMeal.cookedIngredients;
   	
    action prepareMeal: PrepareMeal {
   		in item cookedIngredients;
   		out item completedMeal;
   	} 
   
 }
    