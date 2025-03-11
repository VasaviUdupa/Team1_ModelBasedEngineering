def calculate_ui_score(usability, cost, development_time, feature_set, weights):
    """
    Calculate the user interface score based on provided attributes and their weights.
    
    Args:
    usability (float): Usability rating of the UI.
    cost (float): Cost of developing the UI in dollars.
    development_time (float): Time required to develop the UI in months.
    feature_set (float): Feature set rating of the UI.
    weights (dict): Dictionary of weights for each attribute.
    
    Returns:
    float: Calculated score for the UI.
    """
    score = (weights['usability'] * usability) - \
            (weights['cost'] * (cost / 1000)) - \
            (weights['development_time'] * development_time) + \
            (weights['feature_set'] * feature_set)
    return score

# Attributes for Mobile App and Screen Interface
mobile_app = {
    'usability': 8.0,
    'cost': 20000,
    'development_time': 6,
    'feature_set': 9.0
}

screen_interface = {
    'usability': 7.0,
    'cost': 30000,
    'development_time': 12,
    'feature_set': 8.0
}

# Weights for each attribute
weights = {
    'usability': 0.4,
    'cost': 0.2,
    'development_time': 0.2,
    'feature_set': 0.2
}

# Calculate scores for each user interface option
mobile_app_score = calculate_ui_score(
    mobile_app['usability'], mobile_app['cost'], mobile_app['development_time'], mobile_app['feature_set'], weights
)

screen_interface_score = calculate_ui_score(
    screen_interface['usability'], screen_interface['cost'], screen_interface['development_time'], screen_interface['feature_set'], weights
)

# Print the results
print(f"Mobile App Score: {mobile_app_score:.2f}")
print(f"Screen Interface Score: {screen_interface_score:.2f}")

# Determine which UI is better
if mobile_app_score > screen_interface_score:
    print("The Mobile App is the preferred choice based on the score.")
else:
    print("The Screen Interface is the preferred choice based on the score.")
