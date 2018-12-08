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
    
    enum SwyncMode {
        case halfHour
        case hourly
        case daily
        case weekly
        case monthly
    }
    
    var mode: SwyncMode = .hourly
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
        let op = SwyncOperation2(op: operation)
        OperationQueue.main.addOperation(op)
        
        let dispatchQueue = DispatchQueue.init(label: "swync-dispatch-queue")
        dispatchQueue.async {
            operation.operate({ (result) in
                switch result {
                case .success(let object):
                    break
                case .failed(_): break
                }
            })
        }
    }
    
    func queue(operation: @escaping (() -> OperationResult)) {
        
    }
    
    func perform() {
        
    }
}

fileprivate class SwyncDispatchQueue {
    
    let dispatchQueue: DispatchQueue
    
    init(label: String) {
        self.dispatchQueue = DispatchQueue(label: label)
    }
    
    func add(operation: SwyncOperationProtocol) {
        
    }
}

fileprivate class SwyncMapper {
    
}

class SwyncOperation2: Operation {
    
    let op: SwyncOperationProtocol
    
    init(op: SwyncOperationProtocol) {
        self.op = op
    }
    
    override func main() {
//        op.operate { result in
//
//        }
    }
}

class SwyncOperation3: Operation {
    
    let op: (() -> OperationResult)
    
    init(op: @escaping (() -> OperationResult)) {
        self.op = op
    }
    
    override func main() {
        op()
    }
}
