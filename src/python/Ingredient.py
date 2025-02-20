class Ingredient:
    def __init__(self, name, nutrition, taste, expiration_date):
        self.name = name
        self.nutrition = nutrition
        self.taste = taste
        self.expiration_date = expiration_date


class NutritionInformation:
    def __init__(self, calories, protein, fat, carbohydrates, sugar, sodium):
        self.calories = calories
        self.protein = protein
        self.fat = fat
        self.carbohydrates = carbohydrates
        self.sugar = sugar
        self.sodium = sodium

    def __repr__(self):
        return (f"NutritionInformation(calories={self.calories}, protein={self.protein}, "
                f"fat={self.fat}, carbohydrates={self.carbohydrates}, sugar={self.sugar}, sodium={self.sodium})")


class TasteProfile:
    def __init__(self, sweetness, saltiness, sourness, bitterness, umami):
        self.sweetness = sweetness
        self.saltiness = saltiness
        self.sourness = sourness
        self.bitterness = bitterness
        self.umami = umami

    def __repr__(self):
        return (f"TasteProfile(sweetness={self.sweetness}, saltiness={self.saltiness}, "
                f"sourness={self.sourness}, bitterness={self.bitterness}, umami={self.umami})")
