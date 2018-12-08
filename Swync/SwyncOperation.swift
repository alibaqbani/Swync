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
    case failed(Error)
}

protocol SwyncOperationProtocol {
    
    typealias Completion = ((OperationResult) -> Void)
    
    func operate(_ completion: @escaping Completion)
}

class SwyncOperation: SwyncOperationProtocol {
    var completionHandler: SwyncOperation.Completion?
    
    func operate(_ completion: @escaping Completion) {
        
    }
}
