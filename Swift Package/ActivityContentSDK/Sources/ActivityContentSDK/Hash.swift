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
                  value: String) throws {
        
        /// Throw error if hash value does not follow supported format
        guard ValidationUtil.isValid(hash: value) else {
            throw ActivityContentError.invalidHash
        }
        
        self.algorithm = algorithm
        self.value = value
    }
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if self.algorithm == nil {
            throw ActivityContentError.missingField
        }
        
        if self.value == nil {
            throw ActivityContentError.missingField
        }
        
        if ValidationUtil.isValid(hash: self.value) == false {
            throw ActivityContentError.invalidHash
        }
                
        return true
    }
}
