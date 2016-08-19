//
//  Constants.swift
//  Youplus
//
//  Created by Andrew Fruth on 8/18/16.
//  Copyright © 2016 Huge American Corporation. All rights reserved.
//

import Foundation

struct MessageConstants {
    
    static let maxMessagesToDisplay = 5
    static let avatarName = "avatar"
    static let messageCellID = "messageCell"
    
    private static let date1 = NSDate(timeIntervalSinceReferenceDate: 100000)
    private static let date2 = NSDate(timeIntervalSinceReferenceDate: 100002)
    private static let date3 = NSDate(timeIntervalSinceReferenceDate: 1000007)
    private static let date4 = NSDate(timeIntervalSinceReferenceDate: 1000009)
    private static let date5 = NSDate(timeIntervalSinceReferenceDate: 10000012)
    
    static let message1 = Message(avatarFilename: avatarName, friendName: "Andrew", lastMessage: "How's buddy doing?", lastMessageReceivedTime: date1)
    
    static let message2 = Message(avatarFilename: avatarName, friendName: "Bobby Higginson", lastMessage: "I'm not sure what I think about Buddy Bell.", lastMessageReceivedTime: date2)
    
    static let message3 = Message(avatarFilename: avatarName, friendName: "Robert Downey Jr.", lastMessage: "I think I'm pretty cool. What do you think?", lastMessageReceivedTime: date3)
    
    static let message4 = Message(avatarFilename: avatarName, friendName: "Frank Underwood", lastMessage: "You know what to do. (Grimace)", lastMessageReceivedTime: date4)
    
    static let message5 = Message(avatarFilename: avatarName, friendName: "Kanye", lastMessage: "I'm not married to a hobbit.", lastMessageReceivedTime: date5)
    
}