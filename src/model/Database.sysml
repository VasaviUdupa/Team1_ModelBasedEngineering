package DatabaseManagementSystem {

    private import ScalarValues::*;
    private import SI::*;

    // Define Data Port
    port def DataPort {
        doc /* Interface for data transmission */
        attribute dataFormat: String = "JSON"; // Standard data format
        attribute transferRate: Real = 20; // Mbps, rate at which data is transferred
    }

    // Define Storage Port
    port def StoragePort {
        doc /* Interface for storage systems */
        attribute storageType: String = "Cloud Storage"; // Primary storage type
        attribute capacity: Real = 1024; // GB, total storage capacity
        attribute readWriteSpeed: Real = 500; // MB/s, speed of data storage and retrieval
    }

    // Define Database Management System (DBMS)
    part def DatabaseManagementSystem {
        doc /* System managing food data storage, retrieval, and integrity */

        // Attributes defining DBMS specifications
        attribute databaseType: String = "NoSQL"; // Flexible data model suitable for varied data types
        attribute storageSize: Real = 1024; // GB, total size of the database storage
        attribute securityFeatures: String = "Encryption, Access Control"; // Security measures
        attribute indexPerformance: Real = 100; // Queries per second, performance of data indexing
        attribute faultToleranceLevel: String = "High Availability"; // System reliability and uptime

        // Communication Ports
        port dataInput: DataPort; // Receives data from sensors and user interfaces
        port dataOutput: DataPort; // Outputs data to UI and other system components
        port backupInterface: StoragePort; // Manages backups to secondary storage

        // Actions
        action def StoreData { in data: String; }
        action def RetrieveData { in query: String; out result: String; }
        action def BackupData {}
        action def OptimizeDatabase {}
        action def UpdateData { in newData: String; }
        action def DeleteData { in dataID: String; }

        // Flows
        flow ProcessData {
            action receiveData: StoreData[1];
            action retrieveData: RetrieveData[1];
            action updateData: UpdateData[1];
            action deleteData: DeleteData[1];
            action backupData: BackupData[1];
            action optimize: OptimizeDatabase[1];

            // Data handling sequence
            flow receiveData.data to updateData.newData;
            flow updateData.newData to backupData;
            flow retrieveData.result to deleteData.dataID;
            flow deleteData to optimize;
        }
    }
}
