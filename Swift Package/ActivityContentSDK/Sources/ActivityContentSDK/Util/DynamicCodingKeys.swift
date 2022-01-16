//
//  DynamicCodingKeys.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 1/13/22.
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
