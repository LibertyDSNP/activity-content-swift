//
//  HashUtil.swift
//  ContentActivitySDK
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
    static public func hash(content: String?) -> HexString? {
        guard let content = content else { return nil }
        let hash = content.keccak().hexDescription
        return "0x\(hash)"
    }
}
