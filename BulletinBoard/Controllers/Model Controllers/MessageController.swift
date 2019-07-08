//
//  MessageController.swift
//  BulletinBoard
//
//  Created by Darin Marcus Armstrong on 7/8/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation

class MessageController {
    
    //Shared Instance
    static let shared = MessageController()
    
    let messagesWereUpdatedNotification = Notification.Name("messagesWereUpdated")
    
    //SOT
    var messages: [Message] = [] {
        didSet {
            //Post a notification
            NotificationCenter.default.post(name: messagesWereUpdatedNotification, object: nil)
        }
    }
    
    //MARK: CRUD
    //Create
    func saveMessageRecord(_ text: String) {
        
        //init a message
        let messageToSave = Message(text: text)
        //init a database
        let database = CloudKitController.shared.publicDatabase
        
        CloudKitController.shared.saveRecordToCloudKit(record: messageToSave.cloudKitRecord, database: database) { success in
            if success {
                print("Successfully saved Message to iCloud")
                self.messages.append(messageToSave)
            }
        }
    }
    
    //Read
    func fetchMessageRecords() {
        let database = CloudKitController.shared.publicDatabase
        CloudKitController.shared.fetchRecordsOf(type: Message.typeKey, database: database) { (records, error) in
            
            //Handle the error
            if let error = error {
                print("Error in \(#function) \(error.localizedDescription) /n---/n \(error)")
            }
            
            //Verify that records exist
            guard let foundRecords = records else {return}
            
            //Iterate through foundRecords, init Messages from the values that con init a message, create a new array from the successes
            let messages = foundRecords.compactMap( {Message(record: $0)} )
            
            //Set source of truth
            self.messages = messages
        }
    }
    
    //Update
    
    //Delete
    
}
