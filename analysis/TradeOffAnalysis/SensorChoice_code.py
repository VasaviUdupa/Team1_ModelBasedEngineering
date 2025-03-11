def calculate_sensor_score(mass, power, accuracy, cost, weights):
    """
    Calculate the sensor score based on provided attributes and their weights.
    
    Args:
    mass (float): Mass of the sensor in grams.
    power (float): Power consumption of the sensor in watts.
    accuracy (float): Accuracy of the sensor as a percentage.
    cost (float): Cost of the sensor in dollars.
    weights (dict): Dictionary of weights for each attribute.
    
    Returns:
    float: Calculated score for the sensor.
    """
    # Calculate the score based on the weighted attributes
    score = (weights['mass'] * mass) + \
            (weights['power'] * power) + \
            (-weights['accuracy'] * accuracy) + \
            (weights['cost'] * cost)
    return score

# Define the attributes for the wired and wireless sensors
wired_sensor = {
    'mass': 150,
    'power': 2,
    'accuracy': 95,
    'cost': 40
}

wireless_sensor = {
    'mass': 100,
    'power': 1.5,
    'accuracy': 90,
    'cost': 50
}

# Define the weights for each attribute
weights = {
    'mass': 0.2,
    'power': 0.2,
    'accuracy': 0.4,  # Note: This is treated as negative in the calculation
    'cost': 0.2
}

# Calculate scores for each sensor
wired_score = calculate_sensor_score(
    wired_sensor['mass'], 
    wired_sensor['power'], 
    wired_sensor['accuracy'], 
    wired_sensor['cost'], 
    weights
)

wireless_score = calculate_sensor_score(
    wireless_sensor['mass'], 
    wireless_sensor['power'], 
    wireless_sensor['accuracy'], 
    wireless_sensor['cost'], 
    weights
)

# Print the results
print(f"Wired Sensor Score: {wired_score:.2f}")
print(f"Wireless Sensor Score: {wireless_score:.2f}")

# Determine which sensor is better
if wired_score > wireless_score:
    print("The Wired Sensor is the preferred choice based on the score.")
else:
    print("The Wireless Sensor is the preferred choice based on the score.")
