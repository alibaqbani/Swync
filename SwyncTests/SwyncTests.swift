//
//  SwyncTests.swift
//  SwyncTests
//
//  Created by Ali Baqbani on 12/4/18.
//  Copyright © 2018 Ali Baqbani. All rights reserved.
//

import XCTest
import CoreData
@testable import Swync

class SwyncTests: XCTestCase {

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
        
        Operation<T>.create(closure).execute(on: queue).complete
        
        let context = MockDataContext()
        let swync = SwyncService(context: context)
        
        let operation1 = SwyncOperation()
        let operation2 = SwyncOperation()
        let operation3 = SwyncOperation()
        
        XCTAssertTrue(operation1.state == .idle, "Operation initial state is idle")
        XCTAssertTrue(operation2.state == .idle, "Operation initial state is idle")
        XCTAssertTrue(operation3.state == .idle, "Operation initial state is idle")

        swync.queue(operation: operation1)
        swync.queue(operation: operation2)
        swync.queue(operation: operation3)

        swync.perform()
        
//        XCTAssertTrue(operation.state == .executing, "Operation state is executing")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
