import copy
import simpy
from datetime import date
from src.python.Ingredient import Ingredient
from src.python.Ingredient import NutritionInformation
from src.python.Ingredient import TasteProfile

class IngredientManifestPort:
    def __init__(self, grams, ingredients):
        self.grams = grams  # grams of each ingredient
        self.ingredients = ingredients  # List of Ingredient objects

    def __repr__(self):
        return f"IngredientManifestPort(grams={self.grams}, ingredients={self.ingredients})"


class DataOutputPort:
    def __init__(self, dataFormat, transferRate):
        self.dataFormat = dataFormat  # Data format (e.g., "JSON", "XML")
        self.transferRate = transferRate  # Transfer rate (e.g., 20 Mbps)

    def __repr__(self):
        return f"DataOutputPort(dataFormat='{self.dataFormat}', transferRate={self.transferRate})"


class NetworkPort:
    def __init__(self, protocol, bandwidth):
        self.protocol = protocol  # Network protocol (e.g., "WiFi", "Ethernet")
        self.bandwidth = bandwidth  # Bandwidth (e.g., 100 Mbps)

    def __repr__(self):
        return f"NetworkPort(protocol='{self.protocol}', bandwidth={self.bandwidth})"


# LLM Component
class RecipeLLM:
    def __init__(self, transformerType, BLEUScore, F1Score, processingSpeed, powerConsumption,
                 ingredientManifest, detectionOutput, networkInterface, name='gpt-3.5-turbo'):
        self.name = name  # Name of LLM
        self.transformerType = transformerType  # AI type (e.g., "GPT", "BERT")
        self.BLEUScore = BLEUScore  # BLEU score
        self.F1Score = F1Score  # F1 score
        self.processingSpeed = processingSpeed  # Processing speed (e.g., "50 FPS")
        self.powerConsumption = powerConsumption  # Power consumption (e.g., "5W")
        self.ingredientManifest = ingredientManifest  # IngredientManifestPort object
        self.detectionOutput = detectionOutput  # DataOutputPort object
        self.networkInterface = networkInterface  # NetworkPort object

    def __repr__(self):
        return (f"RecipeLLM(name = {self.name}, transformerType='{self.transformerType}', BLEUScore={self.BLEUScore}, "
                f"F1Score={self.F1Score}, processingSpeed={self.processingSpeed}, powerConsumption={self.powerConsumption}, "
                f"ingredientManifest={self.ingredientManifest}, detectionOutput={self.detectionOutput}, networkInterface={self.networkInterface})")

    def copy(self):
        return copy.deepcopy(self)
