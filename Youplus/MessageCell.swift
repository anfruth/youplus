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
    
    func setupSubViews() {
        setupAvatarFrame()
        setupNameFrame()
//        setupMessageFrame()
//        setupTimeFrame()
    }
    
    private func setupAvatarFrame() {
        avatarFrame = UIImageView(frame: CGRectMake(10, 12.5, 75, 75))
        avatarFrame?.image = UIImage(named: MessageConstants.avatarName)
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
    
    private func setupNameFrame() {
        nameFrame = UILabel()
        nameFrame?.text = "Shite"
        
        if nameFrame != nil {
            addSubview(nameFrame!)
            
            let cellMargins = layoutMarginsGuide
            let avatarMargins = avatarFrame?.layoutMarginsGuide
            nameFrame?.translatesAutoresizingMaskIntoConstraints = false
            
            setNameFrameConstraints(cellMargins, avatarMargins: avatarMargins)
            
        }
    }
    
    private func setNameFrameConstraints(cellMargins: UILayoutGuide, avatarMargins: UILayoutGuide?) {
        
        guard let horizontalConstraint = nameFrame?.leadingAnchor.constraintEqualToAnchor(avatarMargins?.trailingAnchor, constant: 30) else {
            print("problem with nameFrame or avatarMargins not being created")
            return
        }
        
        guard let verticalConstraint = nameFrame?.centerYAnchor.constraintEqualToAnchor(cellMargins.centerYAnchor, constant: -20) else {
            print("problem with nameFrame not being created")
            return
        }
        
        guard let widthConstraint = nameFrame?.widthAnchor.constraintEqualToAnchor(nil, constant: 100) else {
            print("problem with nameFrame not being created")
            return
        }
        
        guard let heightConstraint = nameFrame?.heightAnchor.constraintEqualToAnchor(nil, constant: 100) else {
            print("problem with nameFrame not being created")
            return
        }
        
        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    
    
    
}
