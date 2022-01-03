//
//  Hash.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

class Hash: Codable {
    public var algorithm: String
    public var value: String
    
    init(algorithm: String,
         value: String) {
        self.algorithm = algorithm
        self.value = value
    }
}
