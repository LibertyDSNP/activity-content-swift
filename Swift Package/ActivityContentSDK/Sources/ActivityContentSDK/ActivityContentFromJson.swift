//
//  ActivityContentFromJson.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/11/22.
//

import Foundation

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
