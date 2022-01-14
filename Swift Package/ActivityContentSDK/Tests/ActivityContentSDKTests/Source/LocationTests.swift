//
//  LocationTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/12/22.
//

import XCTest
@testable import ActivityContentSDK

class LocationTests: XCTestCase {
    
    func testLocationEncodePartial() {
        let object = Location(name: "Location Name")
        
        let json = """
            {
              "name" : "Location Name",
              "type" : "Place",
              "units" : "m"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testLocationEncodeFull() {
        let object = Location(name: "Location Name",
                              accuracy: 100,
                              altitude: 50,
                              latitude: 123.45,
                              longitude: -123.45,
                              radius: 25,
                              units: .km)
        
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
        
        XCTAssertEqual(object.json, json)
    }
    
    func testNoteDecode() {
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
        
        let object = Location(json: json)
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
    
    func testLocationIsNotValid_MissingName() {
        do {
            let object = Location()
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingNameField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testLocationIsNotValid_MissingUnits() {
        do {
            let object = Location()
            object.name = "Location"
            object.units = nil
            try object.isValid()
            XCTFail()
        } catch ActivityContentError.missingUnitsField {
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
    
    func testLocationIsValid() {
        do {
            let object = Location()
            object.name = "Location"
            try object.isValid()
            XCTAssertTrue(true)
        } catch {
            XCTFail()
        }
    }
}
