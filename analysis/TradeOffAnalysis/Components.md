## Sensor Trade-Off Analysis

### Wired vs. Wireless Sensor Comparison

| Attribute       | Wired Sensor | Wireless Sensor | Weights | Comments                                |
|-----------------|--------------|-----------------|---------|-----------------------------------------|
| Mass (g)        | 150          | 100             | 0.2     | Lower is better; favors Wireless.       |
| Power (W)       | 2            | 1.5             | 0.2     | Lower is better; favors Wireless.       |
| Accuracy (%)    | 95           | 90              | -0.4    | Higher is better; favors Wired.         |
| **Cost ($) **   | 40           | 50              | 0.2     | Lower is better; favors Wired.          |

**Evaluation Function for Decision Making:**
- Given the weights and attributes: `Score = (0.2 × Mass) + (0.2 × Power) - (0.4 × Accuracy) + (0.2 × Cost)`
- For Wired Sensor: `Score = 30 + 0.4 - 38 + 8 = 0.4`
- For Wireless Sensor: `Score = 20 + 0.3 - 36 + 10 = -5.7`

**Decision:**
- Given the evaluation function that accounts for both pros and cons, the Wired Sensor emerges as the preferable choice due to its higher accuracy, which is critical and carries the most weight in this decision-making process.

## UserApp Choice: Mobile App vs. User Interface

| Attribute                  | Mobile App | Screen Interface | Weights | Comments                               |
|----------------------------|------------|------------------|---------|----------------------------------------|
| Usability (scale)          | 8.0        | 7.0              | 0.4     | Higher is better; favors Mobile App.   |
| **Cost ($) **              | 20,000     | 30,000           | 0.2     | Lower is better; favors Mobile App.    |
| Development Time (months)  | 6          | 12               | 0.2     | Shorter is better; favors Mobile App.  |
| Feature Set (scale)        | 9.0        | 8.0              | 0.2     | More extensive is better; favors Mobile App. |
| Calculated Score           | -0.2       | -4.0             | -       | Higher score is better; favors Mobile App. |

**Evaluation Function for Decision Making:**
- Calculated Scores:
  - For the Mobile App: `Score = 3.2 - 4 - 1.2 + 1.8 = -0.2`
  - For the Screen Interface: `Score = 2.8 - 6 - 2.4 + 1.6 = -4`

**Decision:**
- The Mobile App is chosen due to its superior usability, cost-effectiveness, shorter development timeline, and richer feature set, making it the best fit for the Smart Home Kitchen.

## Camera Choice: Compact vs High-Definition

| Attribute            | Compact Camera | High-Definition Camera | Weights | Comments                               |
|----------------------|----------------|------------------------|---------|----------------------------------------|
| Size (m³)            | 0.002          | 0.005                  | -0.1    | Smaller is better; Compact Camera is favored. |
| **Cost ($) **        | 150            | 300                    | -0.1    | Lower is better; Compact Camera is favored. |
| Accuracy (%)         | 85             | 98                     | 0.6     | Higher is better; High-Definition Camera is favored. |
| Power Consumption (W)| 5              | 10                     | -0.2    | Lower is better; Compact Camera is favored. |

**Decision:**
- Despite the Compact Camera's advantages, the High-Definition Camera's superior accuracy, crucial for capturing clear images, makes it the better choice.

## Computer Hardware Choice: Standard vs High Performance

| Attribute               | Standard Computer System | High-Performance Computer System | Weights | Comments                          |
|-------------------------|--------------------------|----------------------------------|---------|-----------------------------------|
| Size (m³)               | 0.015 (15 liters)        | 0.025 (25 liters)                | -0.1    | Smaller is better; Standard System is favored. |
| Mass (kg)               | 6                        | 10                               | -0.1    | Lighter is better; Standard System is favored. |
| Power Consumption (W)   | 150                      | 400                              | -0.2    | Lower is better; Standard System is favored. |
| Cost (USD)              | 800                      | 1500                             | -0.1    | Lower is better; Standard System is favored. |
| Performance (index)     | 85                       | 95                               | 0.5     | Higher is better; High-Performance is favored. |

**Conclusion and Choice Rationale:**
- The Standard Computer System is chosen for its efficiency, cost-effectiveness, and sufficient performance for typical kitchen tasks.
