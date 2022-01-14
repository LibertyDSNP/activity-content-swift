//
//  ActivityContentFromJson.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/11/22.
//

import Foundation

internal protocol ActivityContentFromJson: Codable {
    
    init?(json: String)
}

internal extension ActivityContentFromJson {

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
