//
//  MonoSync.swift
//  MonoSync
//
//  Created by Ali Baqbani on 12/4/18.
//  Copyright © 2018 Ali Baqbani. All rights reserved.
//

import Foundation

protocol MonoSyncProtocol {
    init(context: MonoSyncContextProtocol)
    
    func queue(operation: MonoSyncOperationProtocol)
    
    func perform()
}

final class MonoSyncService: MonoSyncProtocol {
    
    enum MonoSyncMode {
        case halfHour
        case hourly
        case daily
        case weekly
        case monthly
    }
    
    var mode: MonoSyncMode = .hourly
    var progressive: Bool = false
    var continueOnError: Bool = false
    
    private var context: MonoSyncContextProtocol
    private lazy var operations: [MonoSyncOperationProtocol] = {
        return [MonoSyncOperationProtocol]()
    }()
    
    private lazy var queue: MonoSyncDispatchQueue = {
        return MonoSyncDispatchQueue(label: "mono-sync-dispatch-queue")
    }()
    
    init(context: MonoSyncContextProtocol) {
        self.context = context
    }
    
    func queue(operation: MonoSyncOperationProtocol) {
        let op = MonoSyncOperation2(op: operation)
        OperationQueue.main.addOperation(op)
        
        let dispatchQueue = DispatchQueue.init(label: "mono-sync-dispatch-queue")
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

fileprivate class MonoSyncDispatchQueue {
    
    let dispatchQueue: DispatchQueue
    
    init(label: String) {
        self.dispatchQueue = DispatchQueue(label: label)
    }
    
    func add(operation: MonoSyncOperationProtocol) {
        
    }
}

fileprivate class MonoSyncMapper {
    
}

class MonoSyncOperation2: Operation {
    
    let op: MonoSyncOperationProtocol
    
    init(op: MonoSyncOperationProtocol) {
        self.op = op
    }
    
    override func main() {
//        op.operate { result in
//
//        }
    }
}

class MonoSyncOperation3: Operation {
    
    let op: (() -> OperationResult)
    
    init(op: @escaping (() -> OperationResult)) {
        self.op = op
    }
    
    override func main() {
        op()
    }
}
