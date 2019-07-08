//
//  CloudKitController.swift
//  BulletinBoard
//
//  Created by Darin Marcus Armstrong on 7/8/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitController {
    
    //Shared Instance
    static let shared = CloudKitController()
    
    //Database instances
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    //Create
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        //Save the revord passed in, complete with an optional error
        database.save(record) { (_, error) in
            //handle the error
            if let error = error {
                print("Error in \(#function) \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            }
            print(#function)
            completion(true)
        }
    }
    
    //Read
    func fetchRecordsOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        //Conditions of query, conditions to be return all found values
        let predicate = NSPredicate(value: true)
        //Defines the record type we want to find, applies our predicate conditions
        let query = CKQuery(recordType: type, predicate: predicate)
        //perform query, complete with our optional records and optional error
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) \(error.localizedDescription) /n---/n \(error)")
                completion(nil, error)
            }
            if let records = records {
                completion(records, nil)
            }
        }
    }
}
