//
//  ActivityContentHash.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public class ActivityContentHash: ActivityContentItem {
    
    /**
     The algorithm of the given hash
     */
    public internal(set) var algorithm: String?
    
    /**
     Hash value serialization
     */
    public internal(set) var value: String?

    private let kAlgorithmKeccak = "keccak"

    internal required init() {
        super.init()
    }
    
    internal init(algorithm: String,
                  value: String) {
        self.algorithm = algorithm
        self.value = value
        super.init()
    }
    
    internal init(keccakHashWithString content: String?) {
        self.algorithm = self.kAlgorithmKeccak
        self.value = HashUtil.hash(string: content)
        super.init()
    }
    
    internal init(keccakHashWithData content: Data?) {
        self.algorithm = self.kAlgorithmKeccak
        self.value = HashUtil.hash(data: content)
        super.init()
    }
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case algorithm
        case value
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.algorithm = try? container.decode(String.self, forKey: .algorithm)
        self.value = try? container.decode(String.self, forKey: .value)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.algorithm, forKey: .algorithm)
        try container.encode(self.value, forKey: .value)
    }
    
    @discardableResult
    internal override func isValid() throws -> Bool {
        if self.algorithm == nil {
            throw ActivityContentError.missingAlgorithmField
        }
        
        if self.value == nil {
            throw ActivityContentError.missingHashValueField
        }
        
        if ValidationUtil.isValid(hash: self.value) == false {
            throw ActivityContentError.invalidHash
        }
                
        return try super.isValid()
    }
}
