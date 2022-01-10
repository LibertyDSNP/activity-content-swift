//
//  ValidationUtilTests.swift
//  ActivityContentSDKTests
//
//  Created by Unfinished on 12/27/21.
//

import XCTest
@testable import ActivityContentSDK

class ValidationUtilTests: XCTestCase {

    func testIsValidDsnpUserUri() {
        let valid = [
            "dsnp://1",
            "dsnp://9",
            "dsnp://1034",
            "dsnp://9999",
            "dsnp://12345678901234567890"
        ]
        
        for item in valid {
            XCTAssertTrue(VerificationUtil.isValid(dsnpUserUri: item), "\(item) is invalid.")
        }
    }
    
    func testIsInvalidDsnpUserUri() {
        let invalid = [
            "dsnp://user",
            "dsnp://0",
            "dsnp://0123",
            "dsnp://02345678901234567890",
            "dsnp://123456789012345678901",
            "dsnp://",
            "dsnp:// 1034"
        ]

        for item in invalid {
            XCTAssertFalse(VerificationUtil.isValid(dsnpUserUri: item), "\(item) is valid.")
        }
    }
    
    func testIsValidHref() {
        let valid: [Any?] = [
            "http://www.example.com",
            "https://www.example.com",
            "http://example",
            "http://1",
            URL(string: "http://www.example.com")
        ]
        
        for item in valid {
            XCTAssertTrue(VerificationUtil.isValid(href: item), "\(item!) is invalid.")
        }
    }
    
    func testIsInvalidHref() {
        let invalid: [Any?] = [
            "http:/www",
            "http:www",
            "http://",
            "www.example.com",
            "scheme://www.example.com",
            URL(string: "invalid://www.example.com")
        ]

        for item in invalid {
            XCTAssertFalse(VerificationUtil.isValid(href: item), "\(item!) is valid.")
        }
    }
    
    func testIsValidPublished() {
        let valid = [
            "2000-01-01T00:00:00.000+00:00",
            "2000-01-01T99:99:99",
            "2000-01-01T99:99:99.999",
            "2000-01-01T99:99:99.999Z",
            "0000-00-00T99:99:99.000+19:59",
        ]
        
        for item in valid {
            XCTAssertTrue(VerificationUtil.isValid(date: item), "\(item) is invalid.")
        }
    }
    
    func testIsInvalidPublished() {
        let invalid = [
            "March 14, 2000",
            "Yesterday",
            "99:99:99",
            "2000-01-01",
            "2000-01-01T",
            "2000-01-01T99:99",
            "0000-00-00T99:99:99.000Z19:59",
            "0000-00-00T99:99:99.000Z+19:59",
            "2000-01-01 00:00:00.000",
            "2000-01-01 T 00:00:00.000",
        ]

        for item in invalid {
            XCTAssertFalse(VerificationUtil.isValid(date: item), "\(item) is valid.")
        }
    }

    func testIsValidDuration() {
        // Examples from: http://books.xmlschemata.org/relaxng/ch19-77073.html
        let valid = [
            "PT1004199059S",
            "PT130S",
            "PT2M10S",
            "P1DT2S",
            "-P1Y",
            "P1Y2M3DT5H20M30.123S",
        ]
        
        for item in valid {
            XCTAssertTrue(VerificationUtil.isValid(duration: item), "\(item) is invalid.")
        }
    }
    
    func testIsInvalidDuration() {
        // Examples from: http://books.xmlschemata.org/relaxng/ch19-77073.html
        let invalid = [
            "53 minutes",
            "128",
            "1Y",
            "P1S",
            "P-1Y",
            "P1M2Y",
            "P1Y-1M",
        ]

        for item in invalid {
            XCTAssertFalse(VerificationUtil.isValid(duration: item), "\(item) is valid.")
        }
    }
    
    func testIsValidHash() {
        let valid = [
            "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7",
            "0x00A63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efEA7", // mix case
        ]
        
        for item in valid {
            XCTAssertTrue(VerificationUtil.isValid(hash: item), "\(item) is invalid.")
        }
    }
    
    func testIsInvalidHash() {
        let invalid = [
            "0x00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea", // one char shy
            "0x00A63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efEA7x", // one char long
            "00a63eb58f6ce7fccd93e2d004fed81da5ec1a9747b63f5f1bf80742026efea7", // does not contain prefix 0x
        ]

        for item in invalid {
            XCTAssertFalse(VerificationUtil.isValid(href: item), "\(item) is valid.")
        }
    }
}
