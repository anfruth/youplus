//
//  ViewController.swift
//  Youplus
//
//  Created by Andrew Fruth on 8/18/16.
//  Copyright © 2016 Huge American Corporation. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var addMessageButton: UIBarButtonItem!
    
    private var messages: [Message]?
    private var messagesToAdd: [Message]?
    private var cells: [MessageCell]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cells = [MessageCell(), MessageCell(), MessageCell(), MessageCell(), MessageCell()] // make sure this stays here as log as have implicitly unwrapped optional
        populateMessages()
    }
    
    
    
    @IBAction func addMessage(sender: UIBarButtonItem) {
        addMessageButton.enabled = false
        
        guard let nextMessage = updateTableWithNewCell() else {
            print("Could not retrieve next message")
            addMessageButton.enabled = true
            return
        }
        
        let cellChanging = cells[0]
        
        let activityView = displayActivityView(cellChanging)

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            self.replaceBlankCell(nextMessage, activityView: activityView)
            self.addMessageButton.enabled = true
        }
        
    }
    
    @IBAction func resetMessages(sender: UIBarButtonItem) {
        
        setDefaultMessages()
        messageTable.reloadData()
        
    }
    
    private func populateMessages() {
        
        guard let pathMessagesToAddArray = Message.getPathInDocumentDirectory("messagesToAddArrayM") else {
            print("path for persisting messagesToAdd cannot be found")
            return
        }
        
        guard let pathMessagesArray = Message.getPathInDocumentDirectory("messagesArrayM") else {
            print("path for persisting messages cannot be found")
            return
        }
        
        guard let unarchivedMessagesToAddArray = NSKeyedUnarchiver.unarchiveObjectWithFile(pathMessagesToAddArray) as? [Message],
            let unarchivedMessagesArray = NSKeyedUnarchiver.unarchiveObjectWithFile(pathMessagesArray) as? [Message] else {
            setDefaultMessages()
            return
        }
        
        messages = unarchivedMessagesArray
        messagesToAdd = unarchivedMessagesToAddArray
    
    }
    
    private func setDefaultMessages() {
        messagesToAdd = [MessageConstants.message6, MessageConstants.message7, MessageConstants.message8, MessageConstants.message9, MessageConstants.message10]
        
        // already sorted in order by time, will treat as a queue as I add new messages.
        messages = [MessageConstants.message5, MessageConstants.message4, MessageConstants.message3, MessageConstants.message2, MessageConstants.message1]
    }
    
    private func displayUpdatingCell() -> UIActivityIndicatorView? {
        let cellChanging = cells[0]
        return displayActivityView(cellChanging)
    }
    
    private func updateTableWithNewCell() -> Message? {
        
        guard let nextMessage = messagesToAdd?.first else {
            let alert = UIAlertController(title: "Tha Tha That's all Folks!! :)", message: "Kanye is tired.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            return nil
        }
        
        messages?.removeLast()
        messages?.insert(Message(avatarFilename: "", friendName: "", lastMessage: "", lastMessageReceivedTime: NSDate(), displayAvatar: false, changeDate: true), atIndex:0)
        messageTable.reloadData()
        
        return nextMessage
    }
    
    private func displayActivityView(cellChanging: UITableViewCell) -> UIActivityIndicatorView {
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activityView.startAnimating()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        cellChanging.contentView.addSubview(activityView)
        cellChanging.contentView.bringSubviewToFront(activityView)
        
        setActivityViewConstraints(cellChanging.contentView, activityView: activityView)
        return activityView
    }
    
    private func replaceBlankCell(nextMessage: Message, activityView: UIActivityIndicatorView) {
        messages?.removeFirst()
        nextMessage.setLastMessageReceivedTimeToNow()
        messagesToAdd?.removeFirst()
        messages?.insert(nextMessage, atIndex: 0)
        activityView.removeFromSuperview()
        persistMessages()
        
        UIView.transitionWithView(messageTable,
                                  duration: 0.5,
                                  options: .TransitionCrossDissolve,
                                  animations:
            { () -> Void in
                self.messageTable.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
            },
                                  completion: nil)
    }
    
    private func persistMessages() {
        
        guard let pathMessagesArray = Message.getPathInDocumentDirectory("messagesArrayM") else {
            print("path for persisting messages cannot be found")
            return
        }
        
        guard let pathMessagesToAddArray = Message.getPathInDocumentDirectory("messagesToAddArrayM") else {
            print("path for persisting messagesToAdd cannot be found")
            return
        }
        
        guard let messagesArray = messages else {
            print("messages do not exist")
            return
        }
        
        guard let messagesToAddArray = messagesToAdd else {
            print("messagesToAdd does not exist")
            return
        }
        
        NSKeyedArchiver.archiveRootObject(messagesArray, toFile: pathMessagesArray)
        NSKeyedArchiver.archiveRootObject(messagesToAddArray, toFile: pathMessagesToAddArray)

    }
    
    
    private func setActivityViewConstraints(cellView: UIView, activityView: UIActivityIndicatorView) {
        
        let horizontalConstraint = activityView.centerXAnchor.constraintEqualToAnchor(cellView.layoutMarginsGuide.centerXAnchor)
        let verticalConstraint = activityView.centerYAnchor.constraintEqualToAnchor(cellView.layoutMarginsGuide.centerYAnchor)
        
        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint])
    }
    
    
    // Message Table Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageConstants.maxMessagesToDisplay
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let cell = cells[row]
        
        guard let message = messages?[row] else {
            print("could not get a message from messages array")
            return MessageCell()
        }

        cell.setupSubViews(message.displayAvatar, name: message.friendName, message: message.lastMessage, date: message.lastMessageReceivedTime, changeDate: message.changeDate)
        
        return cell
    }
    
    


}

