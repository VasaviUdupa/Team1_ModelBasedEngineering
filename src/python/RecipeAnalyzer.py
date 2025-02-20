import re
from openai import OpenAI
from src.python.LLMSystem import RecipeLLM, IngredientManifestPort, DataOutputPort, NetworkPort
from src.python.Ingredient import Ingredient, NutritionInformation, TasteProfile


def strip_non_numerical_values(input_string):
    numeric_string = re.sub(r'[^0-9.]', '', input_string)
    if '.' in numeric_string:
        return float(numeric_string)
    else:
        return int(numeric_string)

def get_recipe_from_llm(llm, llm_model, benefits, client):
    ingredients_list = ', '.join([ingredient.name for ingredient in llm.ingredientManifest.ingredients])
    nutrition_info = []
    for ingredient, grams in zip(llm.ingredientManifest.ingredients, llm.ingredientManifest.grams):
        nutrition = ingredient.nutrition
        nutrition_info.append(f"{ingredient.name}: {grams:.2f} grams - {(nutrition.calories*grams/100):.2f} calories, {(nutrition.protein*grams/100):.2f}g protein, {(nutrition.fat*grams/100):.2f}g fat, {(nutrition.carbohydrates*grams/100):.2f}g carbohydrates\n")
    nutrition_info_str = ' '.join(nutrition_info)
    messages = [
        {"role": "system", "content": "You are a culinary expert assistant."},
        {"role": "user", "content": f"Using these available ingredients: {ingredients_list}, and aiming for these nutritional benefits: {', '.join(benefits)}, please recommend a recipe. Consider the expiration dates and quantities provided."},
        {"role": "user", "content": f"Here is the nutrition information for the ingredients: {nutrition_info_str}. Please provide detailed recipe instructions and calculate the total nutrition information for the completed meal in the format calories: <>, protein: <>, fat: <>"}
    ]
    response = client.chat.completions.create(
        model=llm_model,
        messages=messages,
        max_tokens=4096
    )
    return response.choices[0].message.content



def analyze_recipe(recipe, nutrition_info, desired_benefits):
    total_calories = nutrition_info['calories']
    total_protein = nutrition_info['protein']
    total_fat = nutrition_info['fat']

    score = 0

    if "high protein" in desired_benefits:
        protein_ratio = total_protein / total_calories
        score += protein_ratio * 10

    if "low fat" in desired_benefits:
        fat_ratio = total_fat / total_calories
        score += (1 - fat_ratio) * 10

    return score


def main():
    client = OpenAI(
        api_key='')

    # Ingredient nutrition information: https://fdc.nal.usda.gov/
    ingredients = [
        Ingredient(name='Chicken',
                   nutrition=NutritionInformation(calories=112, protein=22.5, fat=1.93, carbohydrates=0, sugar=0,sodium=66),
                   taste=TasteProfile(sweetness=0, saltiness=0, sourness=0, bitterness=0, umami=0),
                   expiration_date="2025-02-20"),
        Ingredient(name='Broccoli',
                   nutrition=NutritionInformation(calories=39, protein=2.57, fat=0.34, carbohydrates=6.27, sugar=1.4, sodium=36),
                   taste=TasteProfile(sweetness=0, saltiness=1, sourness=1, bitterness=0, umami=1),
                   expiration_date="2025-02-17"),
        Ingredient(name='Jasmine Rice',
                   nutrition=NutritionInformation(calories=369, protein=12.8, fat=1.7, carbohydrates=75.7, sugar=0, sodium=16),
                   taste=TasteProfile(sweetness=0, saltiness=0, sourness=0, bitterness=0, umami=0),
                   expiration_date="2025-03-01"),
        Ingredient(name='Garlic',
                   nutrition=NutritionInformation(calories=143, protein=6.62, fat=0.38, carbohydrates=28.2, sugar=0, sodium=0),
                   taste=TasteProfile(sweetness=0, saltiness=0, sourness=0, bitterness=0, umami=1),
                   expiration_date="2025-02-25"),
        Ingredient(name='Soy Sauce',
                   nutrition=NutritionInformation(calories=60, protein=10.5, fat=0.1, carbohydrates=5.57, sugar=1.7, sodium=5590),
                   taste=TasteProfile(sweetness=0, saltiness=5, sourness=0, bitterness=0, umami=4),
                   expiration_date="2025-12-31"),
        Ingredient(name='Cheddar Cheese',
                   nutrition=NutritionInformation(calories=409, protein=23.3, fat=34, carbohydrates=2.44, sugar=0.33, sodium=654),
                   taste=TasteProfile(sweetness=0, saltiness=2, sourness=0, bitterness=0, umami=4),
                   expiration_date="2025-03-15"),
        Ingredient(name='Bacon',
                   nutrition=NutritionInformation(calories=501, protein=40.9, fat=36.9, carbohydrates=2.1, sugar=3.14, sodium=1830),
                   taste=TasteProfile(sweetness=0, saltiness=3, sourness=0, bitterness=0, umami=4),
                   expiration_date="2025-02-25"),
        Ingredient(name='Butter',
                   nutrition=NutritionInformation(calories=717, protein=0.85, fat=81.11, carbohydrates=0.06, sugar=0.06, sodium=714),
                   taste=TasteProfile(sweetness=0, saltiness=0, sourness=0, bitterness=0, umami=1),
                   expiration_date="2025-12-31"),
        Ingredient(name='Chicken Broth',
                   nutrition=NutritionInformation(calories=4, protein=0.5, fat=0, carbohydrates=0.36, sugar=0, sodium=343),
                   taste=TasteProfile(sweetness=0, saltiness=1, sourness=0, bitterness=0, umami=2),
                   expiration_date="2025-12-31"),
        Ingredient(name='Milk',
                   nutrition=NutritionInformation(calories=42, protein=3.4, fat=1, carbohydrates=5, sugar=5, sodium=44),
                   taste=TasteProfile(sweetness=3, saltiness=0, sourness=0, bitterness=0, umami=0),
                   expiration_date="2025-03-01"),
        Ingredient(name='Condensed Cream of Chicken Soup',
                   nutrition=NutritionInformation(calories=103, protein=2, fat=7, carbohydrates=8, sugar=1, sodium=750),
                   taste=TasteProfile(sweetness=1, saltiness=2, sourness=0, bitterness=0, umami=3),
                   expiration_date="2025-12-31"),
    ]

    desired_benefits = ["high protein", "low fat"]
    ingredient_manifest = IngredientManifestPort(
        grams=[500, 300, 100, 50, 100, 150, 300, 100, 1000, 400, 200], ingredients=ingredients)
    detection_output = DataOutputPort(dataFormat="JSON", transferRate=20)
    network_interface = NetworkPort(protocol="WiFi", bandwidth=100)
    llm = RecipeLLM(transformerType="GPT", BLEUScore=0.85, F1Score=0.9, processingSpeed="50 FPS", powerConsumption="5W",
                    ingredientManifest=ingredient_manifest, detectionOutput=detection_output,
                    networkInterface=network_interface)

    llm_models = ["gpt-3.5-turbo", "gpt-4"]
    for llm_model in llm_models:
        dut_llm = llm.copy()
        dut_llm.name = llm_model
        recipe = get_recipe_from_llm(dut_llm, llm_model, desired_benefits, client)

        nutrition_info = {
            'calories': 0,
            'protein': 0,
            'fat': 0,
            'carbohydrates': 0
        }
        lines = recipe.split('\n')
        for line in lines:
            if 'Calories' in line:
                nutrition_info['calories'] = strip_non_numerical_values(line.split(': ')[1].split(' ')[0])
            if 'Protein' in line:
                nutrition_info['protein'] = strip_non_numerical_values(line.split(': ')[1].split(' ')[0])
            if 'Fat' in line:
                nutrition_info['fat'] = strip_non_numerical_values(line.split(': ')[1].split(' ')[0])

        score = analyze_recipe(recipe, nutrition_info, desired_benefits)
        print(f"Model: {llm_model}")
        print(f"Recipe:\n{recipe}\n")
        print(f"Recipe Score: {score}\n")


if __name__ == '__main__':
    main()
