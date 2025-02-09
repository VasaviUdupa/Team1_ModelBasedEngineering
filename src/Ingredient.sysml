package Ingredient {
	
	private import ScalarValues::*;
	
	//Define Ingredient
	attribute def Ingredient {
	  	attribute nutrition : NutritionInformation;
	  	attribute taste : TasteProfile;
	  	attribute expirationDate : Time::Date;
	}
	
	// Define the nutrition infromation
	attribute def NutritionInformation {
  		attribute calories : Integer;
		attribute protein : Integer;
		attribute fat : Integer;
		attribute carbohydrates : Integer;
		attribute sugar: Integer;
		attribute sodium: Integer;
	}
	
	// Define the taste profile
	attribute def TasteProfile {
		attribute sweetness : Real;
	 	attribute saltiness : Real;
	  	attribute sourness : Real;
	  	attribute bitterness : Real;
	 	attribute umami : Real;
	}
}
