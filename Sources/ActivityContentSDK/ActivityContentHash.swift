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
    public internal(set) var algorithm: AlgorithmType?
    public enum AlgorithmType: Codable, Equatable {
        case keccak
        case custom(algorithm: String)
        
        init?(string: String?) {
            guard let string = string else { return nil }
            switch string {
            case "keccak":
                self = .keccak
            default:
                self = .custom(algorithm: string)
            }
        }
        
        var stringValue: String {
            switch self {
            case .keccak:
                return "keccak"
            case .custom(let algorithm):
                return algorithm
            }
        }
    }
    
    /**
     Hash value serialization
     */
    public internal(set) var value: String?

    internal required init() {
        super.init()
    }
    
    internal init(algorithm: AlgorithmType,
                  value: String) {
        self.algorithm = algorithm
        self.value = value
        super.init()
    }
    
    internal init(keccakHashWithString content: String?) {
        self.algorithm = .keccak
        self.value = HashUtil.hash(string: content)
        super.init()
    }
    
    internal init(keccakHashWithData content: Data?) {
        self.algorithm = .keccak
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
        
        // Convert algorithm string to enum
        let algorithmString = try? container.decode(String.self, forKey: .algorithm)
        self.algorithm = AlgorithmType(string: algorithmString)
        
        self.value = try? container.decode(String.self, forKey: .value)
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let algorithm = self.algorithm {
            try container.encode(algorithm.stringValue, forKey: .algorithm)
        }
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
