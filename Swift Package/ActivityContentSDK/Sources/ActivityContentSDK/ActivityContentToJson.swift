//
//  ActivityContentToJson.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/6/22.
//

import Foundation

internal struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    init?(intValue: Int) {
        /// We are not using this, return nil
        return nil
    }
}

public protocol ActivityContentToJson: Codable {
    
    var json: String? { get }
}

public extension ActivityContentToJson {
    
    var json: String? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
}
