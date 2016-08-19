//
//  ViewController.swift
//  Youplus
//
//  Created by Andrew Fruth on 8/18/16.
//  Copyright © 2016 Huge American Corporation. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let message = Message(avatarFilename: "/avatar_filepath", friendName: "Andrew", lastMessage: "Hey Buddy", lastMessageReceivedTime: NSDate())
        
        // http://mhorga.org/2015/08/25/ios-persistence-with-nscoder-and-nskeyedarchiver.html inspiration
        var filePath: String? {
            let manager = NSFileManager.defaultManager()
            let url = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
            
            guard let unwrappedURL = url else {
                print("unable to get first url in user domain document directory")
                return nil
            }
            
            return unwrappedURL.URLByAppendingPathComponent("messages").path
        }
        
        print(filePath)
        
        guard let unwrappedFilePath = filePath else {
            print("file path could not be created by appending path component")
            // display error to user, cannot persist messages, app error
            return
        }
        
        NSKeyedArchiver.archiveRootObject(message, toFile: unwrappedFilePath)
        guard let unarchivedMessage = NSKeyedUnarchiver.unarchiveObjectWithFile(unwrappedFilePath) as? Message else {
            print("Could not retrieve persisted messages")
            // display error to user
            return
        }
        
        print(unarchivedMessage.avatarFilename)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

