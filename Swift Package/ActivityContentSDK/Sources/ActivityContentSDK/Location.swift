//
//  Location.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation
import AnyCodable

public enum LocationUnits: String, Codable {
    case cm, feet, inches, km, m, miles
}

public class Location: ActivityContentToJson, ActivityContentFromJson, ActivityContentCustomFields {
    var additionalFields: [String : AnyCodable]?
    
    /**
     Identifies the type of the object
     
     - Requires: MUST be set to Place
     */
    public private(set) var type: String = "Place"
    
    /**
     The display name for the location
     */
    public internal(set) var name: String?
    
    /**
     The accuracy of the coordinates as a percentage. (e.g. "94.0" means "94.0% accurate")
     */
    public internal(set) var accuracy: Float?
    
    /**
     The altitude of the location
     */
    public internal(set) var altitude: Float?
    
    /**
     The latitude of the location
     */
    public internal(set) var latitude: Double?
    
    /**
     The longitude of the location
     */
    public internal(set) var longitude: Double?
    
    /**
     The area around the given point that comprises the location
     */
    public internal(set) var radius: Float?
    
    /**
     The units for radius and altitude (defaults to meters)
     
     - Requires: MUST be one of: cm, feet, inches, km, m, miles
     */
    public internal(set) var units: LocationUnits? = .m
    
    internal var storedJson: String?
    
    internal init(name: String,
                  accuracy: Float? = nil,
                  altitude: Float? = nil,
                  latitude: Double? = nil,
                  longitude: Double? = nil,
                  radius: Float? = nil,
                  units: LocationUnits? = .m) {
        self.name = name
        self.accuracy = accuracy
        self.altitude = altitude
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.units = units
    }
    
    internal init() {}
    
    @discardableResult
    internal func isValid() throws -> Bool {
        if self.name == nil {
            throw ActivityContentError.missingNameField
        }
        
        if self.units == nil {
            throw ActivityContentError.missingUnitsField
        }
        
        return true
    }
}
