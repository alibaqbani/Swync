//
//  MonoSyncObject.swift
//  MonoSync
//
//  Created by Ali Baqbani on 12/7/18.
//  Copyright © 2018 Ali Baqbani. All rights reserved.
//

import Foundation

protocol MonoSyncObjectProtocol {
    init(value: Any)
}

protocol MonoSyncMapperProtocol {
    func map(value: Any) -> MonoSyncObjectProtocol
}
