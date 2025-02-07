package Ingredient {
	part def Ingredient {
	  attribute nutrition : NutritionInformation;
	  attribute taste : TasteProfile;
	  attribute expirationDate : Time::Date;
	}
}

attribute def NutritionInformation {
	private import ScalarValues::*;
	
  	attribute calories : Integer;
  	attribute protein : Integer;
  	attribute fat : Integer;
  	attribute carbohydrates : Integer;
  	attribute sugar: Integer;
  	attribute sodium: Integer;
}


attribute def TasteProfile {
	private import ScalarValues::*;
	
	attribute sweetness : Real;
 	attribute saltiness : Real;
  	attribute sourness : Real;
  	attribute bitterness : Real;
 	attribute umami : Real;
}