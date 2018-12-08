//
//  MonoSyncOperation.swift
//  MonoSync
//
//  Created by Ali Baqbani on 12/7/18.
//  Copyright © 2018 Ali Baqbani. All rights reserved.
//

import Foundation

enum OperationResult {
    case success(MonoSyncObjectProtocol)
    case failed(Error)
}

protocol MonoSyncOperationProtocol {
    
    typealias Completion = ((OperationResult) -> Void)
    
    func operate(_ completion: @escaping Completion)
}

class MonoSyncOperation: MonoSyncOperationProtocol {
    var completionHandler: MonoSyncOperation.Completion?
    
    func operate(_ completion: @escaping Completion) {
        
    }
}
