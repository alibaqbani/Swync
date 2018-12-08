//
//  SwyncObject.swift
//  Swync
//
//  Created by Ali Baqbani on 12/7/18.
//  Copyright © 2018 Ali Baqbani. All rights reserved.
//

import Foundation

protocol SwyncObjectProtocol {
    init(value: Any)
}

protocol SwyncMapperProtocol {
    func map(value: Any) -> SwyncObjectProtocol
}
