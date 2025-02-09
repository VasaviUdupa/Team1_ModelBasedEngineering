package LLMSystem {
	
	private import Ingredient::*;
	private import Recipe::*;
    private import ScalarValues::*;
    private import SI::*;
   

    // Define Ingredient Manifest Port
    port def IngredientManifestPort {
        doc /* Manifest of avalible ingredients */
        attribute grams :> gram [*]; // e.g., 250g
        attribute ingredients : Ingredient [*]; // e.g., 'Banana', 'Chicken'
    }

    // Define Data Output Port
    port def DataOutputPort {
        doc /* Processed data output */
        attribute dataFormat: String; // e.g., "JSON", "XML"
        attribute transferRate: Real; // e.g., "20 Mbps"
    }

    // Define Network Port
    port def NetworkPort {
        doc /* Network interface for AI model updates */
        attribute protocol: String; // e.g., "WiFi", "Ethernet"
        attribute bandwidth: Real; // e.g., "100 Mbps"
    }
    
    // Define the LLM Component
    part def RecipeLLM {
        doc /* AI-based LLM for recipe generation */

        // Attributes defining AI processing specifications
        attribute transformerType: String; // e.g., "GPT", "BERT", T5
        attribute BLEUScore: Real; // e.g., 0 to 1
        attribute F1Score: Real; // e.g., 0 to 1
        attribute processingSpeed: Real; // e.g., "50 FPS"
        attribute powerConsumption: Real; // e.g., "5W"

        // Communication Ports
        port ingredientManifest: IngredientManifestPort; // Receives ingredient manifest from database
        port detectionOutput: DataOutputPort; // Sends processed recipe
        port networkInterface: NetworkPort; // Connects to cloud or database for AI updates
    }
    
    
    // Define Actions for LLM Processing Workflow
    action def ReceiveManifest { out rawIngredients: Ingredient [*]; }
    action def ProccessManifest { 
    	in rawIngredients: Ingredient [*]; 
    	action redefines  Recipe::RecipeFoodFlow;
    	out recipe :> Recipe::RecipeFoodFlow;
    }
    action def SendRecipe { in recipe :> Recipe::RecipeFoodFlow; }
    
    // Define Flow for LLM Processing
    action LLMWorkflow {
        action receiveManifest: ReceiveManifest[1];
        action proccessManifest: ProccessManifest[1];
        action sendRecipe: SendRecipe[1];

        flow receiveManifest.rawIngredients to proccessManifest.rawIngredients;
        flow proccessManifest.rawIngredients to sendRecipe.recipe;
    }
    
}
