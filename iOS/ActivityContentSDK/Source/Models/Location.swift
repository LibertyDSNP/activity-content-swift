//
//  Location.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

enum LocationUnits: String, Codable {
    case cm, feet, inches, km, m, miles
}

struct Location: Codable {
    public private(set) var type: String = "Place"
    public var name: String
    public var accuracy: Float?
    public var altitude: Float?
    public var latitude: Float?
    public var longitude: Float?
    public var radius: Float?
    public var units: LocationUnits?
}
