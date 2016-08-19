//
//  Message.swift
//  Youplus
//
//  Created by Andrew Fruth on 8/18/16.
//  Copyright © 2016 Huge American Corporation. All rights reserved.
//

import Foundation

class Message: NSObject, NSCoding {
    
    private(set) var avatarFilename: String
    private(set) var friendName: String
    private(set) var lastMessage: String
    private(set) var lastMessageReceivedTime: NSDate
    
    init(avatarFilename: String, friendName: String, lastMessage: String, lastMessageReceivedTime: NSDate) {
        self.avatarFilename = avatarFilename
        self.friendName = friendName
        self.lastMessage = lastMessage
        self.lastMessageReceivedTime = lastMessageReceivedTime
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let avatarFilename = decoder.decodeObjectForKey("avatarFilename") as? String,
            let friendName = decoder.decodeObjectForKey("friendName") as? String,
            let lastMessage = decoder.decodeObjectForKey("lastMessage") as? String,
            let lastMessageReceivedTime = decoder.decodeObjectForKey("lastMessageReceivedTime") as? NSDate
            else { return nil } // decoding has failed
        
        self.init(
            avatarFilename: avatarFilename,
            friendName: friendName,
            lastMessage: lastMessage,
            lastMessageReceivedTime: lastMessageReceivedTime
        )
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(avatarFilename, forKey: "avatarFilename")
        coder.encodeObject(friendName, forKey: "friendName")
        coder.encodeObject(lastMessage, forKey: "lastMessage")
        coder.encodeObject(lastMessageReceivedTime, forKey: "lastMessageReceivedTime")
    }
    
    func getPathInDocumentDirectory(componentToAppend: String) -> String? {
        let manager = NSFileManager.defaultManager()
        let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
        
        guard let unwrappedURL = url else {
            print("unable to get first url in user domain document directory")
            return nil
        }
        
        return unwrappedURL.URLByAppendingPathComponent(componentToAppend).path
    }
    
    
}