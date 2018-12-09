//
//  Swync.swift
//  Swync
//
//  Created by Ali Baqbani on 12/4/18.
//  Copyright © 2018 Ali Baqbani. All rights reserved.
//

import Foundation

protocol SwyncProtocol {
    init(context: SwyncContextProtocol)
    
    func queue(operation: SwyncOperationProtocol)
    
    func perform()
}

final class SwyncService: SwyncProtocol {
    
    var progressive: Bool = false
    var continueOnError: Bool = false
    
    private var context: SwyncContextProtocol
    private lazy var operations: [SwyncOperationProtocol] = {
        return [SwyncOperationProtocol]()
    }()
    
    private lazy var queue: SwyncDispatchQueue = {
        return SwyncDispatchQueue(label: "swync-dispatch-queue")
    }()
    
    init(context: SwyncContextProtocol) {
        self.context = context
    }
    
    func queue(operation: SwyncOperationProtocol) {
        var operation = operation
        operation.completion = { [unowned self] result in
            self.handle(result: result)
        }
        
        operations.append(operation)
//        handle(operation: operation)
    }
    
    private func handle(result: OperationResult) {
        switch result {
        case .failed(let error):
            print(error)
            break
        case .success(let value):
            print(value)
            break
        }
    }
    
    func perform() {
        queue.add(operations: operations)
    }
}

fileprivate class SwyncDispatchQueue {
    
    let dispatchQueue: DispatchQueue
    
    init(label: String) {
        self.dispatchQueue = DispatchQueue(label: label, qos: .background, attributes: [.concurrent])
    }
    
    func add(operations: [SwyncOperationProtocol]) {
        operations.forEach({ executeAsync($0.execute) })
    }
    
    func add(operation: SwyncOperationProtocol) {
        executeAsync(operation: operation)
    }
    
    private func executeAsync(operation: SwyncOperationProtocol) {
        let dispatchWorkItem = DispatchWorkItem(block: operation.execute)
        dispatchQueue.async(execute: dispatchWorkItem)
        
        dispatchQueue.async {
            operation.execute()
        }
    }
    
    private func executeAsync(_ closure: @escaping (() -> Void)) {
        dispatchQueue.async {
            closure()
        }
    }
}

