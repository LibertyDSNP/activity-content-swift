//
//  ActivityContentCustomFields.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/12/22.
//

import Foundation
import AnyCodable

internal protocol ActivityContentCustomFields: ActivityContentFromJson {
 
    var additionalFields: [String : Any]? { get set }
    
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
