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
    public var algorithm: String
    
    /**
     Hash value serialization
     */
    public var value: String
    
    init(algorithm: String,
         value: String) throws {
        
        /// Throw error if hash value does not follow supported format
        guard VerificationUtil.isValid(hash: value) else {
            throw ActivityContentError.invalidHash
        }
        
        self.algorithm = algorithm
        self.value = value
    }
}
