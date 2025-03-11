def calculate_computer_score(size, mass, power_consumption, cost, performance, weights):
    """
    Calculate the computer score based on provided attributes and their weights.
    
    Args:
    size (float): Size of the computer in cubic meters.
    mass (float): Mass of the computer in kilograms.
    power_consumption (float): Power consumption of the computer in watts.
    cost (float): Cost of the computer in dollars.
    performance (float): Performance index of the computer.
    weights (dict): Dictionary of weights for each attribute.
    
    Returns:
    float: Calculated score for the computer.
    """
    # Convert size from cubic meters to liters for calculation simplicity
    size_liters = size * 1000
    
    # Calculate the score using the weighted attributes
    score = (-weights['size'] * size_liters) - \
            (weights['mass'] * mass) - \
            (weights['power_consumption'] * power_consumption) - \
            (weights['cost'] * cost) + \
            (weights['performance'] * performance)
    return score

# Attributes for Standard and High-Performance Computers
standard_computer = {
    'size': 0.015,  # in cubic meters
    'mass': 6,
    'power_consumption': 150,
    'cost': 800,
    'performance': 85
}

high_performance_computer = {
    'size': 0.025,  # in cubic meters
    'mass': 10,
    'power_consumption': 400,
    'cost': 1500,
    'performance': 95
}

# Weights for each attribute
weights = {
    'size': 0.1,
    'mass': 0.1,
    'power_consumption': 0.2,
    'cost': 0.1,
    'performance': 0.5
}

# Calculate scores for each computer
standard_computer_score = calculate_computer_score(
    standard_computer['size'],
    standard_computer['mass'],
    standard_computer['power_consumption'],
    standard_computer['cost'],
    standard_computer['performance'],
    weights
)

high_performance_computer_score = calculate_computer_score(
    high_performance_computer['size'],
    high_performance_computer['mass'],
    high_performance_computer['power_consumption'],
    high_performance_computer['cost'],
    high_performance_computer['performance'],
    weights
)

# Print the results
print(f"Standard Computer System Score: {standard_computer_score:.2f}")
print(f"High-Performance Computer System Score: {high_performance_computer_score:.2f}")

# Determine which computer system is better based on the higher score
if standard_computer_score > high_performance_computer_score:
    print("The Standard Computer System is the preferred choice based on the score.")
else:
    print("The High-Performance Computer System is the preferred choice based on the score.")
