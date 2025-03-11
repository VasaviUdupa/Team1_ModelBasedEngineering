def calculate_camera_score(size, cost, accuracy, power_consumption, weights):
    """
    Calculate the camera score based on provided attributes and their weights.
    
    Args:
    size (float): Size of the camera in cubic meters.
    cost (float): Cost of the camera in dollars.
    accuracy (float): Accuracy of the camera as a percentage.
    power_consumption (float): Power consumption of the camera in watts.
    weights (dict): Dictionary of weights for each attribute.
    
    Returns:
    float: Calculated score for the camera.
    """
    # Convert size from cubic meters to liters for a more intuitive scale in calculation
    size_liters = size * 1000
    
    # Calculate the score using the weighted attributes
    score = (-weights['size'] * size_liters) - \
            (weights['cost'] * cost) + \
            (weights['accuracy'] * accuracy) - \
            (weights['power_consumption'] * power_consumption)
    return score

# Camera attributes
compact_camera = {
    'size': 0.002,  # in cubic meters
    'cost': 150,
    'accuracy': 85,
    'power_consumption': 5
}

high_definition_camera = {
    'size': 0.005,  # in cubic meters
    'cost': 300,
    'accuracy': 98,
    'power_consumption': 10
}

# Weights for each attribute
weights = {
    'size': 0.1,
    'cost': 0.1,
    'accuracy': 0.6,  # Increased weight for accuracy due to its importance
    'power_consumption': 0.2
}

# Calculate scores for each camera
compact_camera_score = calculate_camera_score(
    compact_camera['size'],
    compact_camera['cost'],
    compact_camera['accuracy'],
    compact_camera['power_consumption'],
    weights
)

high_definition_camera_score = calculate_camera_score(
    high_definition_camera['size'],
    high_definition_camera['cost'],
    high_definition_camera['accuracy'],
    high_definition_camera['power_consumption'],
    weights
)

# Print the results
print(f"Compact Camera Score: {compact_camera_score:.2f}")
print(f"High-Definition Camera Score: {high_definition_camera_score:.2f}")

# Determine which camera is better based on the higher score
if compact_camera_score > high_definition_camera_score:
    print("The Compact Camera is the preferred choice based on the score.")
else:
    print("The High-Definition Camera is the preferred choice based on the score.")
