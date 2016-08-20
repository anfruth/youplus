//
//  MessageCell.swift
//  Youplus
//
//  Created by Andrew Fruth on 8/18/16.
//  Copyright © 2016 Huge American Corporation. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    private var avatarFrame: UIImageView?
    private var nameFrame: UILabel?
    private var messageFrame: UITextView?
    private var timeFrame: UILabel?
    private var cellMargins: UILayoutGuide! // must be automatically set
    
    func setupSubViews(displayAvatar: Bool, name: String, message: String, date: NSDate, changeDate: Bool) {
        resetReusableCell()
        cellMargins = layoutMarginsGuide
        
        setupAvatarFrame(displayAvatar)
        setupNameFrame(name)
        setupMessageFrame(displayAvatar, message: message)
        setupTimeFrame(date, changeDate: changeDate)
    }
    
    private func resetReusableCell() {
        avatarFrame?.removeFromSuperview()
        nameFrame?.removeFromSuperview()
        messageFrame?.removeFromSuperview()
        timeFrame?.removeFromSuperview()
    }
    
    private func setupAvatarFrame(displayAvatar: Bool) {
        avatarFrame = UIImageView(frame: CGRectMake(10, 12.5, 75, 75))
        if displayAvatar {
            avatarFrame?.image = UIImage(named: MessageConstants.avatarName)
        }
        avatarFrame?.contentMode = .Center
        
        // http://stackoverflow.com/questions/4414221/uiimage-in-a-circle
        guard let frameHeight = avatarFrame?.frame.size.height else {
            print("could not retrieve height of avatar frame")
            return
        }
        
        avatarFrame?.layer.cornerRadius = frameHeight / 2
        avatarFrame?.layer.masksToBounds = false
        avatarFrame?.clipsToBounds = true
        
        if avatarFrame != nil {
            addSubview(avatarFrame!)
        } else {
            print("avatar frame not created correctly")
        }
    }
    
    private func setupNameFrame(name: String) {
        nameFrame = UILabel()
        nameFrame?.text = name
        
        if nameFrame != nil {
            addSubview(nameFrame!)
            
            let avatarMargins = avatarFrame?.layoutMarginsGuide
            nameFrame?.translatesAutoresizingMaskIntoConstraints = false
            
            setNameFrameConstraints(avatarMargins)
            
        }
    }
    
    private func setupMessageFrame(displayAvatar: Bool, message: String) {
        messageFrame = UITextView()
        if !displayAvatar {
            messageFrame?.hidden = true
        }
        
        messageFrame?.text = message
        messageFrame?.textContainer.maximumNumberOfLines = 2
        messageFrame?.textContainer.lineBreakMode = .ByTruncatingTail
        messageFrame?.userInteractionEnabled = false
        messageFrame?.editable = false
        
        if messageFrame != nil {
            addSubview(messageFrame!)
            
            let avatarMargins = avatarFrame?.layoutMarginsGuide
            let nameMargins = nameFrame?.layoutMarginsGuide
            messageFrame?.translatesAutoresizingMaskIntoConstraints = false
            
            setMessageFrameConstraints(avatarMargins, nameMargins: nameMargins)
            
        }
    }
    
    private func setupTimeFrame(date: NSDate, changeDate: Bool) {
        timeFrame = UILabel()
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "MMM dd, HH:mm"
        
        if changeDate {
            timeFrame?.text = ""
        } else {
            timeFrame?.text = dateFormatter.stringFromDate(date)
        }
    
        timeFrame?.textAlignment = .Right
        
        if timeFrame != nil {
            addSubview(timeFrame!)
            
            timeFrame?.translatesAutoresizingMaskIntoConstraints = false
            setTimeFrameContraints()
        }
    }
    
    private func setNameFrameConstraints(avatarMargins: UILayoutGuide?) {
        
        guard let horizontalConstraint = nameFrame?.leadingAnchor.constraintEqualToAnchor(avatarMargins?.trailingAnchor, constant: 20) else {
            return
        }
        
        guard let verticalConstraint = nameFrame?.centerYAnchor.constraintEqualToAnchor(cellMargins.centerYAnchor, constant: -20) else {
            return
        }
        
        guard let heightConstraint = nameFrame?.heightAnchor.constraintEqualToAnchor(nil, constant: 20) else {
            return
        }
        
        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, heightConstraint])
    }
    
    private func setMessageFrameConstraints(avatarMargins: UILayoutGuide?, nameMargins: UILayoutGuide?) {
        
        guard let horizontalConstraint = messageFrame?.leadingAnchor.constraintEqualToAnchor(nameMargins?.leadingAnchor, constant: -12) else { // -12 needed because of margin built into UITextView
            return
        }
        
        guard let verticalConstraint = messageFrame?.topAnchor.constraintEqualToAnchor(nameMargins?.bottomAnchor, constant: 10) else {
            return
        }
        
        guard let widthConstraintRightSide = messageFrame?.trailingAnchor.constraintEqualToAnchor(cellMargins?.trailingAnchor, constant: -20) else {
            return
        }
        
        guard let heightConstraint = messageFrame?.heightAnchor.constraintEqualToAnchor(nil, constant: 40) else {
            return
        }
        
         NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraintRightSide, heightConstraint])
    }
    
    private func setTimeFrameContraints() {
        
        guard let horizontalConstraint = timeFrame?.trailingAnchor.constraintEqualToAnchor(cellMargins.trailingAnchor, constant: -10) else {
            return
        }
        
        guard let horizontalConstraintLeft = timeFrame?.leadingAnchor.constraintEqualToAnchor(nameFrame?.trailingAnchor, constant: -20) else {
            return
        }
        
        guard let verticalConstraint = timeFrame?.centerYAnchor.constraintEqualToAnchor(nameFrame?.centerYAnchor) else {
            return
        }
        
        guard let widthConstraint = timeFrame?.widthAnchor.constraintEqualToAnchor(nil, constant: 120) else {
            return
        }
        
        guard let heightConstraint = timeFrame?.heightAnchor.constraintEqualToAnchor(nameFrame?.heightAnchor) else {
            return
        }
        
        NSLayoutConstraint.activateConstraints([horizontalConstraint, horizontalConstraintLeft, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    
    
    
    
    
}
