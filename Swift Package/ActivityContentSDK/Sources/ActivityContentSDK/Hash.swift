//
//  Hash.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public class Hash: ActivityContentItem {
    
    /**
     The algorithm of the given hash
     */
    internal var algorithm: String?
    
    /**
     Hash value serialization
     */
    internal var value: String?
    
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
