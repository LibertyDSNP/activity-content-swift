//
//  Hash.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation
import AnyCodable

public class Hash: ActivityContentToJson, ActivityContentFromJson, ActivityContentCustomFields {
    var additionalFields: [String : AnyCodable]?
    
    /**
     The algorithm of the given hash
     */
    public internal(set) var algorithm: String?
    
    /**
     Hash value serialization
     */
    public internal(set) var value: String?

    internal var storedJson: String?
    
    internal init() {
    }
    
    internal init(algorithm: String,
                  value: String) {
        self.algorithm = algorithm
        self.value = value
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if self.algorithm == nil {
            throw ActivityContentError.missingAlgorithmField
        }
        
        if self.value == nil {
            throw ActivityContentError.missingHashValueField
        }
        
        if ValidationUtil.isValid(hash: self.value) == false {
            throw ActivityContentError.invalidHash
        }
                
        return true
    }
}
