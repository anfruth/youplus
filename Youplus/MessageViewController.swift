//
//  ViewController.swift
//  Youplus
//
//  Created by Andrew Fruth on 8/18/16.
//  Copyright © 2016 Huge American Corporation. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageTable: UITableView!
    
    private var messages: [Message]?
    private var messagesToAdd: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateMessages()
    }
    
    @IBAction func addMessage(sender: UIBarButtonItem) {
        
        guard let nextMessage = messagesToAdd?.first else {
            let alert = UIAlertController(title: "Tha Tha That's all Folks!! :)", message: "Kanye is tired.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        nextMessage.setLastMessageReceivedTimeToNow()
        messages?.removeLast()
        messagesToAdd?.removeFirst()
        messages?.insert(nextMessage, atIndex: 0)
        
        UIView.transitionWithView(messageTable,
                                  duration: 0.5,
                                  options: .TransitionCrossDissolve,
                                  animations:
                                    { () -> Void in
                                    self.messageTable.reloadData()
                                    },
                                  completion: nil)
        
        
    }
    
    private func populateMessages() {
        // already sorted in order by time, will treat as a queue as I add new messages.
        messagesToAdd = [MessageConstants.message6, MessageConstants.message7, MessageConstants.message8, MessageConstants.message9, MessageConstants.message10]
        
        messages = [MessageConstants.message5, MessageConstants.message4, MessageConstants.message3, MessageConstants.message2, MessageConstants.message1]
    }
    
    // Message Table Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageConstants.maxMessagesToDisplay
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(MessageConstants.messageCellID) as? MessageCell else {
            print("could not dequeue cell, found nothing")
            return UITableViewCell()
        }
        
        let row = indexPath.row
        
        guard let message = messages?[row] else {
            print("could not get a message from messages array")
            return UITableViewCell()
        }

        cell.setupSubViews(message.friendName, message: message.lastMessage, date: message.lastMessageReceivedTime)
        
        return cell
    }
    
    


}

