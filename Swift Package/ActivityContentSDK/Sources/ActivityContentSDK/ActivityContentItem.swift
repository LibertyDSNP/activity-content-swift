//
//  File.swift
//  
//
//  Created by Rigo Carbajal on 1/6/22.
//

import Foundation

protocol ActivityContentItem: Codable {
    var json: String? { get }
    static func from(json: String) -> Self?
};

extension ActivityContentItem {
    
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
    
    static func from(json: String) -> Self? {
        do {
            let decoder = JSONDecoder()
            let root = try decoder.decode(Self.self, from: Data(json.utf8))
            return root
        } catch {
            print(error)
            return nil
        }
    }
}
