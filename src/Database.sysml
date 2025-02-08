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
        
        // Communication Ports
        port dataInput: DataPort;  // Receives data from other components
        port dataOutput: DataPort; // Sends data to other components
        port backupInterface: StoragePort; // Interface for data backup
        
        // Actions
        action StoreData { in data: String; }
        action RetrieveData { in query: String; out result: String; }
        action BackupData {}
    }
}
