//
//  ActivityContentTests_Location.swift
//  ActivityContentTests
//
//  Created by Unfinished on 12/22/21.
//

import XCTest
@testable import ActivityContentSDK
import CoreLocation

class ActivityContentTests_Location: XCTestCase {
    
    func testBuildWithParams() {
        let object = try? ActivityContent.Builders.Location()
            .setName("Location Name")
            .setAccuracy(50)
            .setAltitude(100)
            .setCoordinate(CLLocationCoordinate2D(latitude: 123.45, longitude: -123.45))
            .setRadius(25)
            .setUnits(.cm)
            .addAdditionalFields(["custom" : true])
            .build()
        
        XCTAssertEqual(object?.accuracy, 50)
        XCTAssertEqual(object?.altitude, 100)
        XCTAssertEqual(object?.latitude, 123.45)
        XCTAssertEqual(object?.longitude, -123.45)
        XCTAssertEqual(object?.name, "Location Name")
        XCTAssertEqual(object?.radius, 25)
        XCTAssertEqual(object?.type, "Place")
        XCTAssertEqual(object?.units, .cm)
        XCTAssertEqual(object?.additionalFields["custom"] as? Bool, true)
    }
    
    func testBuildWithInvalidJson() {
        let builder = ActivityContent.Builders.Location(json: "invalid")
        XCTAssertNil(builder)
    }
    
    func testBuildWithValidJson() {
        let json = """
            {
              "accuracy" : 100,
              "altitude" : 50,
              "latitude" : 123.45,
              "longitude" : -123.45,
              "name" : "Location Name",
              "radius" : 25,
              "type" : "Place",
              "units" : "km"
            }
            """
        
        let object = try? ActivityContent.Builders.Location(json: json)?.build()
        XCTAssertNotNil(object)
        XCTAssertEqual(object?.accuracy, 100)
        XCTAssertEqual(object?.altitude, 50)
        XCTAssertEqual(object?.latitude, 123.45)
        XCTAssertEqual(object?.longitude, -123.45)
        XCTAssertEqual(object?.name, "Location Name")
        XCTAssertEqual(object?.radius, 25)
        XCTAssertEqual(object?.type, "Place")
        XCTAssertEqual(object?.units, .km)

    }
    
    func testBuildWithValidJsonInvalidObject() {
        let json = """
            {
              "accuracy" : 100,
              "altitude" : 50,
              "latitude" : 123.45,
              "longitude" : -123.45,
              "name" : "Location Name",
              "radius" : 25,
              "type" : "Invalid",
              "units" : "km"
            }
            """
        let builder = ActivityContent.Builders.Location(json: json)
        XCTAssertNotNil(builder)
        let object = try? builder?.build()
        XCTAssertNil(object)
    }
}
