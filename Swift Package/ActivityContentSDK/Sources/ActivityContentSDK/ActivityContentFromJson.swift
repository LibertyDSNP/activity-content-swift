//
//  ActivityContentFromJson.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/11/22.
//

import Foundation
import AnyCodable

internal protocol ActivityContentFromJson: Codable {
    
    var storedJson: String? { get set }
    
    init?(json: String)
}

internal extension ActivityContentFromJson {

    init?(json: String) {
        do {
            let decoder = JSONDecoder()
            var root = try decoder.decode(Self.self, from: Data(json.utf8))
            root.storedJson = json
            self = root
        } catch {
            print(error)
            return nil
        }
    }
}

internal protocol ActivityContentCustomFields: ActivityContentFromJson {
 
    var additionalFields: [String : AnyCodable]? { get set }
    
    func getValue(key: String) -> Any?
}

internal extension ActivityContentCustomFields {
    
    func getValue(key: String) -> Any? {
        if let data = self.storedJson?.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]
                return json?[key]
            } catch {
                print(error)
            }
        }
        
        return nil
    }
}
