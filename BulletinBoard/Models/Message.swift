//
//  Message.swift
//  BulletinBoard
//
//  Created by Darin Marcus Armstrong on 7/8/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    //Keys for cloudKit storage
    static let typeKey = "Message"
    private let textKey = "Text"
    private let timestampKey = "Timestamp"
    
    //Class Properties
    let text: String
    let timestamp: Date
    
    var cloudKitRecord: CKRecord {
        //Define the record type
        let record = CKRecord(recordType: Message.typeKey)
        // Set you key value pairs
        record.setValue(text, forKey: textKey)
        record.setValue(timestamp, forKey: timestampKey)
        // Return the record
        return record
    }
    
    //Class Initializer
    init(text: String, timestamp: Date = Date()) {
        self.text = text
        self.timestamp = timestamp
    }
    
    //Convenience init to pass in CKRecord
    init?(record: CKRecord) {
        //Guard against keys
        guard let text = record[textKey] as? String,
        let timestamp = record[timestampKey] as? Date
            else {return nil}
        
        self.text = text
        self.timestamp = timestamp
    }
}
