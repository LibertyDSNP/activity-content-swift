//
//  Location.swift
//  ActivityContentSDK
//
//  Created by Unfinished on 12/27/21.
//

import Foundation

public enum LocationUnits: String, Codable {
    case cm, feet, inches, km, m, miles
}

public class Location: ActivityContentItem {
    
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
        super.init()
    }
    
    internal override init() {
        super.init()
    }
    
    internal override var allKeys: [CodingKey] { return super.allKeys + CodingKeys.allCases }
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case type,
             name,
             accuracy,
             altitude,
             latitude,
             longitude,
             radius,
             units
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.name = try? container.decode(String.self, forKey: .name)
        self.accuracy = try? container.decode(Float.self, forKey: .accuracy)
        self.altitude = try? container.decode(Float.self, forKey: .altitude)
        self.latitude = try? container.decode(Double.self, forKey: .latitude)
        self.longitude = try? container.decode(Double.self, forKey: .longitude)
        self.radius = try? container.decode(Float.self, forKey: .radius)
        self.units = try? container.decode(LocationUnits.self, forKey: .units)
        
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        if let name = self.name {
            try? container.encode(name, forKey: .name)
        }
        if let accuracy = self.accuracy {
            try? container.encode(accuracy, forKey: .accuracy)
        }
        if let altitude = self.altitude {
            try? container.encode(altitude, forKey: .altitude)
        }
        if let latitude = self.latitude {
            try? container.encode(latitude, forKey: .latitude)
        }
        if let longitude = self.longitude {
            try? container.encode(longitude, forKey: .longitude)
        }
        if let radius = self.radius {
            try? container.encode(radius, forKey: .radius)
        }
        if let units = self.units {
            try? container.encode(units, forKey: .units)
        }
    }
    
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
