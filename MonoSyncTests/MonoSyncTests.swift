//
//  MonoSyncTests.swift
//  MonoSyncTests
//
//  Created by Ali Baqbani on 12/4/18.
//  Copyright © 2018 Ali Baqbani. All rights reserved.
//

import XCTest
import CoreData
@testable import MonoSync

class MonoSyncTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSync() {
        
        let context = MockDataContext()
        let sync = MonoSync(context: context)
        sync.mode = .daily
        sync.progressive = false
        sync.continueOnError = false
        
        sync.perform { source -> MonoSyncModel in
        }
        
//        try! sync.perform(with: ["username": "test"], target: User.self)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
