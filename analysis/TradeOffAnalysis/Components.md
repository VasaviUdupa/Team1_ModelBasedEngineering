Sensor Choice - Wired vs wireless

| Attribute | Wired Sensor | Wireless Sensor | Weights | Comments                         |
|-----------|--------------|-----------------|---------|----------------------------------|
| Mass (g)  | 150          | 100             | 0.2     | Lower is better; favors Wireless.|
| Power (W) | 2            | 1.5             | 0.2     | Lower is better; favors Wireless.|
| Accuracy (%) | 95        | 90              | -0.4    | Higher is better; favors Wired.  |
| **Cost ($) ** | 40       | 50              | 0.2     | Lower is better; favors Wired.   |

Evaluation Function for Decision Making:
Given the weights and attributes: Score=(0.2×Mass)+(0.2×Power)−(0.4×Accuracy)+(0.2×Cost)\text{Score} = (0.2 \times \text{Mass}) + (0.2 \times \text{Power}) - (0.4 \times \text{Accuracy}) + (0.2 \times \text{Cost})Score=(0.2×Mass)+(0.2×Power)−(0.4×Accuracy)+(0.2×Cost)
For Wired Sensor: Score=(0.2×150)+(0.2×2)−(0.4×95)+(0.2×40)\text{Score} = (0.2 \times 150) + (0.2 \times 2) - (0.4 \times 95) + (0.2 \times 40)Score=(0.2×150)+(0.2×2)−(0.4×95)+(0.2×40) Score=30+0.4−38+8=0.4\text{Score} = 30 + 0.4 - 38 + 8 = 0.4Score=30+0.4−38+8=0.4
For Wireless Sensor: Score=(0.2×100)+(0.2×1.5)−(0.4×90)+(0.2×50)\text{Score} = (0.2 \times 100) + (0.2 \times 1.5) - (0.4 \times 90) + (0.2 \times 50)Score=(0.2×100)+(0.2×1.5)−(0.4×90)+(0.2×50) Score=20+0.3−36+10=−5.7\text{Score} = 20 + 0.3 - 36 + 10 = -5.7Score=20+0.3−36+10=−5.7
Decision:
Given the evaluation function that accounts for both pros and cons, the Wired Sensor emerges as the preferable choice despite its higher mass and power usage:
•	Accuracy: The higher accuracy of the Wired Sensor is critical and carries the most weight in this decision-making process.
•	Cost: It is also more cost-effective compared to the Wireless Sensor.


UserApp choice:  Mobil app VS User Interface
| Attribute          | Mobile App | Screen Interface | Weights | Comments                              |
|--------------------|------------|------------------|---------|---------------------------------------|
| Usability (scale)  | 8.0        | 7.0              | 0.4     | Higher is better; favors Mobile App.  |
| **Cost ($) **      | 20,000     | 30,000           | 0.2     | Lower is better; favors Mobile App.   |
| Development Time (months) | 6    | 12               | 0.2     | Shorter is better; favors Mobile App. |
| Feature Set (scale)| 9.0        | 8.0              | 0.2     | More extensive is better; favors Mobile App. |
| Calculated Score   | -0.2       | -4.0             | -       | Higher score is better; favors Mobile App.   |

Evaluation Function for Decision Making:
Given the weights and attributes: Score=(0.4×Usability)−(0.2×Cost1000)−(0.2×Development Time)+(0.2×Feature Set)\text{Score} = (0.4 \times \text{Usability}) - (0.2 \times \frac{\text{Cost}}{1000}) - (0.2 \times \text{Development Time}) + (0.2 \times \text{Feature Set})Score=(0.4×Usability)−(0.2×1000Cost)−(0.2×Development Time)+(0.2×Feature Set)
Calculated Scores:
For the Mobile App: Score=(0.4×8.0)−(0.2×20)−(0.2×6)+(0.2×9.0)=3.2−4−1.2+1.8=−0.2\text{Score} = (0.4 \times 8.0) - (0.2 \times 20) - (0.2 \times 6) + (0.2 \times 9.0) = 3.2 - 4 - 1.2 + 1.8 = -0.2Score=(0.4×8.0)−(0.2×20)−(0.2×6)+(0.2×9.0)=3.2−4−1.2+1.8=−0.2
For the Screen Interface: Score=(0.4×7.0)−(0.2×30)−(0.2×12)+(0.2×8.0)=2.8−6−2.4+1.6=−4\text{Score} = (0.4 \times 7.0) - (0.2 \times 30) - (0.2 \times 12) + (0.2 \times 8.0) = 2.8 - 6 - 2.4 + 1.6 = -4Score=(0.4×7.0)−(0.2×30)−(0.2×12)+(0.2×8.0)=2.8−6−2.4+1.6=−4
Decision:
•	Higher Usability: The Mobile App scores higher in usability, which is crucial for user satisfaction and ease of use.
•	Lower Cost: At $20,000, the Mobile App is significantly cheaper than the $30,000 Screen Interface, making it more cost-effective.
•	Shorter Development Time: The Mobile App can be developed in half the time required for the Screen Interface, allowing quicker deployment and feedback integration.
•	Superior Feature Set: With a higher feature set rating, the Mobile App provides more functionality and a better user experience.
Final Choice: Based on the calculated scores which reflect a balance between performance and cost efficiencies, the Mobile App is chosen for the Smart Home Kitchen due to its superior usability, cost-effectiveness, shorter development timeline, and richer feature set. This decision supports the project's objectives to provide a user-friendly, efficient, and feature-rich interface for the Smart Home Kitchen environment.


Camera choice: Compact vs High-Definition

| Attribute         | Compact Camera | High-Definition Camera | Weights | Comments                                   |
|-------------------|----------------|------------------------|---------|--------------------------------------------|
| Size (m³)         | 0.002          | 0.005                  | -0.1    | Smaller is better; Compact Camera is favored. |
| **Cost ($) **     | 150            | 300                    | -0.1    | Lower is better; Compact Camera is favored. |
| Accuracy (%)      | 85             | 98                     | 0.6     | Higher is better; High-Definition Camera is favored. |
| Power Consumption (W) | 5          | 10                     | -0.2    | Lower is better; Compact Camera is favored. |

For the Compact Camera: Score=(−0.1×2×1000)−(0.1×150)+(0.6×85)−(0.2×5)\text{Score} = (-0.1 \times 2 \times 1000) - (0.1 \times 150) + (0.6 \times 85) - (0.2 \times 5)Score=(−0.1×2×1000)−(0.1×150)+(0.6×85)−(0.2×5) Score=−200−15+51−1=−165\text{Score} = -200 - 15 + 51 - 1 = -165Score=−200−15+51−1=−165
For the High-Definition Camera: Score=(−0.1×5×1000)−(0.1×300)+(0.6×98)−(0.2×10)\text{Score} = (-0.1 \times 5 \times 1000) - (0.1 \times 300) + (0.6 \times 98) - (0.2 \times 10)Score=(−0.1×5×1000)−(0.1×300)+(0.6×98)−(0.2×10) Score=−500−30+58.8−2=−473.2\text{Score} = -500 - 30 + 58.8 - 2 = -473.2Score=−500−30+58.8−2=−473.2
Decision
Despite the Compact Camera's advantages in terms of size, cost, and power consumption, the High-Definition Camera's superior accuracy (98% vs. 85%) is the critical factor, especially given its heavy weight in the scoring system (0.6). This higher accuracy is crucial for capturing clear images that can reliably discern details such as expiration dates on food products, which is a core requirement for the Smart Home Kitchen.
Final Choice: 
The High-Definition Camera is chosen over the Compact Camera due to its significantly higher accuracy, which outweighs its larger size, higher cost, and greater power consumption. This decision ensures the kitchen's capability to effectively manage food safety and quality, aligning with the project's goals to enhance user experience and operational efficiency through advanced technology.



Computer hardware choice : Standard VS High performance
| Attribute             | Compact Camera | High-Definition Camera | Weights | Comments                                          |
|-----------------------|----------------|------------------------|---------|---------------------------------------------------|
| Size (m³)             | 0.002          | 0.005                  | -0.1    | Smaller is better; Compact Camera is favored.     |
| **Cost ($) **         | 150            | 300                    | -0.1    | Lower is better; Compact Camera is favored.       |
| Accuracy (%)          | 85             | 98                     | 0.6     | Higher is better; High-Definition Camera is favored. |
| Power Consumption (W) | 5              | 10                     | -0.2    | Lower is better; Compact Camera is favored.       |

Calculation Using the Revised Weights
The score can be calculated using the following formula: Score=(−0.1×Size in liters×1000)−(0.1×Mass)−(0.2×Power Consumption)−(0.1×Cost)+(0.5×Performance)\text{Score} = (-0.1 \times \text{Size in liters} \times 1000) - (0.1 \times \text{Mass}) - (0.2 \times \text{Power Consumption}) - (0.1 \times \text{Cost}) + (0.5 \times \text{Performance})Score=(−0.1×Size in liters×1000)−(0.1×Mass)−(0.2×Power Consumption)−(0.1×Cost)+(0.5×Performance)
Calculated Scores:
For the Standard Computer System: Score=(−0.1×15×1000)−(0.1×6)−(0.2×150)−(0.1×800)+(0.5×85)\text{Score} = (-0.1 \times 15 \times 1000) - (0.1 \times 6) - (0.2 \times 150) - (0.1 \times 800) + (0.5 \times 85)Score=(−0.1×15×1000)−(0.1×6)−(0.2×150)−(0.1×800)+(0.5×85) Score=−1500−0.6−30−80+42.5=−1568.1\text{Score} = -1500 - 0.6 - 30 - 80 + 42.5 = -1568.1Score=−1500−0.6−30−80+42.5=−1568.1
For the High-Performance Computer System: Score=(−0.1×25×1000)−(0.1×10)−(0.2×400)−(0.1×1500)+(0.5×95)\text{Score} = (-0.1 \times 25 \times 1000) - (0.1 \times 10) - (0.2 \times 400) - (0.1 \times 1500) + (0.5 \times 95)Score=(−0.1×25×1000)−(0.1×10)−(0.2×400)−(0.1×1500)+(0.5×95) Score=−2500−1−80−150+47.5=−2683.5\text{Score} = -2500 - 1 - 80 - 150 + 47.5 = -2683.5Score=−2500−1−80−150+47.5=−2683.5
Conclusion and Choice Rationale:
•	Size and Power Consumption: The Standard Computer System is more compact and consumes less power, which is beneficial for kitchen integration where space and energy efficiency are important.
•	Cost: The Standard Computer System is significantly cheaper, making it more cost-effective.
•	Performance: While the High-Performance Computer System offers superior performance, the significant increase in cost, size, and power consumption might not justify the performance gains for typical kitchen tasks.
Final Choice: Based on the simplified score calculations and the weighted importance of each criterion, the Standard Computer System appears to be the more balanced choice when considering cost, size, power consumption, and sufficient performance for the Smart Home Kitchen's needs. This decision supports the project's objectives to provide a cost-effective, efficient, and compact computer solution without overly compromising on performance.
4





