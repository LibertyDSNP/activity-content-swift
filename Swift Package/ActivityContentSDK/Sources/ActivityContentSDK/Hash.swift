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
    public var algorithm: String?
    
    /**
     Hash value serialization
     */
    public var value: String?
    
    internal init() {
    }
    
    init(algorithm: String,
         value: String) throws {
        
        /// Throw error if hash value does not follow supported format
        guard VerificationUtil.isValid(hash: value) else {
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
        
        if VerificationUtil.isValid(hash: self.value) == false {
            throw ActivityContentError.invalidHash
        }
                
        return true
    }
}
