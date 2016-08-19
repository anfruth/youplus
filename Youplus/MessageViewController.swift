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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateMessages()
    }
    
    private func populateMessages() {
        // already sorted in order by time, will treat as a queue as I add new messages.
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
        
        cell.setupSubViews()
        
        return cell
    }
    
    


}

