//
//  HashUtil.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation
import SwiftKeccak

extension Data {
    var hexDescription: String {
        return self.reduce("") {$0 + String(format: "%02x", $1)}
    }
}

class HashUtil {
    static func hash(string: String?) -> HexString? {
        guard let string = string else { return nil }
        let hash = string.keccak().hexDescription
        return "0x\(hash)"
    }
    
    static func hash(data: Data?) -> HexString? {
        guard let data = data else { return nil }
        let hash = data.keccak().hexDescription
        return "0x\(hash)"
    }
}
