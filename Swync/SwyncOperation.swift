//
//  SwyncOperation.swift
//  Swync
//
//  Created by Ali Baqbani on 12/7/18.
//  Copyright © 2018 Ali Baqbani. All rights reserved.
//

import Foundation

enum OperationResult {
    case success(SwyncObjectProtocol)
    case failed(Error?)
}

enum SwyncOperationState {
    case idle
    case executing
    case finished
    case canceled
}

protocol SwyncOperationProtocol {
    
    typealias Completion = ((OperationResult) -> Void)
    
    var state: SwyncOperationState { get }
    
    var completion: Completion? { get set }
    
    func execute()
    
    func cancel()
}

internal class InternalSwyncOperation {
    
    let operation: SwyncOperation
    
    init(operation: SwyncOperation) {
        self.operation = operation
    }
}

class SwyncOperation: SwyncOperationProtocol {
    
    internal(set) var state: SwyncOperationState = .idle
    
    var completion: Completion?
    
    init() {
    }
    
    func execute() {
        state = .executing
        if let completion = completion {
            completion(.failed(nil))
        }
    }
    
    func cancel() {
        
    }
}

protocol SwyncCancelable {
    
}

protocol OperationWrapper {
    associatedtype R
    
    func execute() -> R
}

struct OperationWrapper2<T> {
    typealias R = T
    
    init(_ closure: () -> T) {
        
    }
}

