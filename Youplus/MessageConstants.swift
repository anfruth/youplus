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
    
    private static let date1 = NSDate(timeIntervalSinceReferenceDate: 493270010)
    private static let date2 = NSDate(timeIntervalSinceReferenceDate: 493271028)
    private static let date3 = NSDate(timeIntervalSinceReferenceDate: 493272028)
    private static let date4 = NSDate(timeIntervalSinceReferenceDate: 493283028)
    private static let date5 = NSDate(timeIntervalSinceReferenceDate: 493293109)
    
    static let message1 = Message(avatarFilename: avatarName, friendName: "Andrew", lastMessage: "How's buddy doing?", lastMessageReceivedTime: date1, displayAvatar: true)
    
    static let message2 = Message(avatarFilename: avatarName, friendName: "Bobby Higginson", lastMessage: "I'm not sure what I think about Buddy Bell.", lastMessageReceivedTime: date2, displayAvatar: true)
    
    static let message3 = Message(avatarFilename: avatarName, friendName: "Robert Downey Jr.", lastMessage: "I think I'm pretty cool. What do you think?", lastMessageReceivedTime: date3, displayAvatar: true)
    
    static let message4 = Message(avatarFilename: avatarName, friendName: "Frank Underwood", lastMessage: "You know what to do. (Grimace)", lastMessageReceivedTime: date4, displayAvatar: true)
    
    static let message5 = Message(avatarFilename: avatarName, friendName: "Kanye", lastMessage: "I'm not married to a hobbit. I am married to a beautiful woman. Just because she smokes a pipe and lives underground does not make her a hobbit.", lastMessageReceivedTime: date5, displayAvatar: true)
    
    static let message6 = Message(avatarFilename: avatarName, friendName: "Kim K", lastMessage: "Did you just call me a hobbit? Kanye said so. How dare you.", lastMessageReceivedTime: nil, displayAvatar: true)
    
    static let message7 = Message(avatarFilename: avatarName, friendName: "Officer McGradyyyyyyyyyyyyyyyyyyy", lastMessage: "We have reports of angry Hobbits heading your way. Consider them short and dangerous.", lastMessageReceivedTime: nil, displayAvatar: true)
    
    static let message8 = Message(avatarFilename: avatarName, friendName: "Kanye", lastMessage: "Kim and I are coming to talk to you along with some of her friends who like to smoke pipes", lastMessageReceivedTime: nil, displayAvatar: true)
    
    static let message9 = Message(avatarFilename: avatarName, friendName: "Kanye", lastMessage: "I am the greatest.", lastMessageReceivedTime: nil, displayAvatar: true)
    
    static let message10 = Message(avatarFilename: avatarName, friendName: "Kanye", lastMessage: "Seriously, you better say I am, you better.", lastMessageReceivedTime: nil, displayAvatar: true)
    
}