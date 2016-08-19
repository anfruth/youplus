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
    
    private var messages: [Message]?
    private var messagesToAdd: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateMessages()
    }
    
    @IBAction func addMessage(sender: UIBarButtonItem) {
        
        guard let nextMessage = updateTableWithNewCell() else {
            print("Could not retrieve next message")
            return
        }
        
        guard let cellChanging = messageTable.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) else {
            print("could not find cell to change")
            return
        }
        
        let activityView = displayActivityView(cellChanging)

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            self.replaceBlankCell(nextMessage, activityView: activityView)
        }
        
        
    }
    
    private func populateMessages() {
        // already sorted in order by time, will treat as a queue as I add new messages.
        messagesToAdd = [MessageConstants.message6, MessageConstants.message7, MessageConstants.message8, MessageConstants.message9, MessageConstants.message10]
        
        messages = [MessageConstants.message5, MessageConstants.message4, MessageConstants.message3, MessageConstants.message2, MessageConstants.message1]
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
        messages?.insert(Message(avatarFilename: "", friendName: "", lastMessage: "", lastMessageReceivedTime: nil, displayAvatar: false), atIndex:0)
        
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
        
        UIView.transitionWithView(messageTable,
                                  duration: 0.5,
                                  options: .TransitionCrossDissolve,
                                  animations:
            { () -> Void in
                self.messageTable.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
            },
                                  completion: nil)
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
        guard let cell = tableView.dequeueReusableCellWithIdentifier(MessageConstants.messageCellID) as? MessageCell else {
            print("could not dequeue cell, found nothing")
            return UITableViewCell()
        }
        
        let row = indexPath.row
        
        guard let message = messages?[row] else {
            print("could not get a message from messages array")
            return UITableViewCell()
        }

        cell.setupSubViews(message.displayAvatar, name: message.friendName, message: message.lastMessage, date: message.lastMessageReceivedTime)
        
        return cell
    }
    
    


}

