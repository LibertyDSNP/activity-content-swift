//
//  ActivityContentItem.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/6/22.
//

import Foundation

public protocol ActivityContentItem: Codable {
    
    // to JSON
    var json: String? { get }
    
    // from JSON
    init?(json: String)
}

public extension ActivityContentItem {
    
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
    
    init?(json: String) {
        do {
            let decoder = JSONDecoder()
            let root = try decoder.decode(Self.self, from: Data(json.utf8))
            self = root
        } catch {
            print(error)
            return nil
        }
    }
}
