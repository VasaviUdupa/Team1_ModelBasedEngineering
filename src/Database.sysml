package SmartHomeKitchenComponents {

    import ScalarValues::*;
    import SI::*;

    // Define Database Management System (DBMS)
    part def DatabaseManagementSystem {
        doc /* Manages data storage, retrieval, and integrity for the smart kitchen */

        // Attributes defining the DBMS specifications
        attribute databaseType: String;  // e.g., "SQL", "NoSQL"
        attribute storageSize: Real;  // e.g., "1TB"
        attribute securityFeatures: String;  // e.g., "Encryption, Access Control"
        attribute indexPerformance: Real;  // e.g., "100 queries/sec"
        attribute faultToleranceLevel: String;  // e.g., "High Availability"

        // Communication Ports
        port dataInput: DataPort;  // Receives data from sensors and user inputs
        port dataOutput: DataPort; // Sends data to UI and other systems
        port backupInterface: StoragePort; // Interface for data backup

        // Actions
        action StoreData { in data: String; }
        action RetrieveData { in query: String; out result: String; }
        action BackupData {}
        action OptimizeDatabase {}
    }
}
