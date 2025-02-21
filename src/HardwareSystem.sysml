package HardwareSystem {
    private import ScalarValues::*;
    private import SI::*;

    // Define Power Interface
    interface def PowerInterface {
        flow electricalPower: Current;
    }

    // Define Components with Ports and Attributes
    part def PowerSystem {
        port out powerOut: PowerInterface;
        attribute voltage: Volt;
    }

    part def WiringHarness {
        port in powerIn: PowerInterface;
        port out powerOut: PowerInterface;
        attribute wireGauge: Integer;
    }

    part def Refrigerator {
        port in powerIn: PowerInterface;
        attribute temperature: Celsius;
    }

    // Define relationships between Fridge, Wiring Harness, and Power System
    part def FridgeSystemConnections {
        ref part refrigerator: Refrigerator;
        ref part wiringHarness: WiringHarness;
        ref part powerSystem: PowerSystem;

        // Relationships
        association RefrigeratorToWiringHarness {
            from refrigerator;
            to wiringHarness;
        }

        association WiringHarnessToPowerSystem {
            from wiringHarness;
            to powerSystem;
        }
    }
}
