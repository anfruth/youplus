//
//  YouplusTests.swift
//  YouplusTests
//
//  Created by Andrew Fruth on 8/18/16.
//  Copyright © 2016 Huge American Corporation. All rights reserved.
//

import XCTest
@testable import Youplus

class YouplusTests: XCTestCase {
    
    private var message: Message!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMessageCreation() {
        message = Message(avatarFilename: "/avatar_filepath", friendName: "Andrew", lastMessage: "Hey Buddy", lastMessageReceivedTime: NSDate())
        XCTAssertNotNil(message)
    }
    
    
}
