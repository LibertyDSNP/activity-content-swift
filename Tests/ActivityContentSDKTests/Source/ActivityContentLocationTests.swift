//
//  ActivityContentLocationTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 1/12/22.
//

import XCTest
@testable import ActivityContentSDK

class ActivityContentLocationTests: XCTestCase {
    
    func testActivityContentLocationEncodePartial() {
        let object = ActivityContentLocation(name: "Location Name")
        
        let json = """
            {
              "name" : "Location Name",
              "type" : "Place",
              "units" : "m"
            }
            """
        
        XCTAssertEqual(object.json, json)
    }
    
    func testActivityContentLocationEncodeFull() {
        let object = ActivityContentLocation(name: "Location Name",
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
    
    func testActivityContentNoteDecode() {
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
        
        let object = ActivityContentLocation(json: json)
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
    
    func testActivityContentLocationIsNotValid_InvalidType() {
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
        
        let object = ActivityContentLocation(json: json)
        do {
            try object?.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.invalidType)
        }
    }
    
    func testActivityContentLocationIsNotValid_MissingName() {
        do {
            let object = ActivityContentLocation()
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.missingLocationNameField)
        }
    }
    
    func testActivityContentLocationIsNotValid_MissingUnits() {
        do {
            let object = ActivityContentLocation()
            object.name = "Location"
            object.units = nil
            try object.isValid()
            XCTFail()
        } catch {
            XCTAssertTrue((error as? ActivityContentError) == ActivityContentError.missingUnitsField)
        }
    }
    
    func testActivityContentLocationIsValid() {
        let object = ActivityContentLocation()
        object.name = "Location"
        XCTAssertTrue(try! object.isValid())
    }
}
