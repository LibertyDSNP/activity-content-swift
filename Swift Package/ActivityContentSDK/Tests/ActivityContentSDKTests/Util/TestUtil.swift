//
//  TestUtil.swift
//  ActivityContentSDKTests
//
//  Created by Rigo Carbajal on 1/3/22.
//

import Foundation

class TestUtil {
    
//    static public func json<T: Encodable>(object: T) -> String? {
//        do {
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
//            let jsonData = try encoder.encode(object)
//            return String(data: jsonData, encoding: .utf8)
//        } catch {
//            print(error)
//            return nil
//        }
//    }
    
    static public func object<T: Decodable>(with: T.Type, json: String) -> T? {
        do {
            let decoder = JSONDecoder()
            let root = try decoder.decode(T.self, from: Data(json.utf8))
            return root
        } catch {
            print(error)
            return nil
        }
    }
}
