//
//  UnitTests.swift
//  EFDTests
//
//  Created by Mohamed El Fakharany on 01/03/2024.
//

import XCTest

@testable import EFD

class CalculatorTests: XCTestCase {
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    func testAddition() {
        XCTAssertEqual(calculator.add(2, 3), 5, "Adding 2 and 3 should result in 5")
    }
}

class AuthenticationManagerTests: XCTestCase {

    func testSuccessfulLogin() {
        let email = "ezezez"
        let password = "ezezez"
        
            ConnexionWebServices.connectUser(email: email, password: password) { error, success, user in
            XCTAssertTrue(success ?? false, "Login should succeed")
        }
    }
    
    func testFailedLogin() {
        let expectation = self.expectation(description: "Login failed")
        let email = "test@test.com"
        let password = "wrongpassword"
        
        ConnexionWebServices.connectUser(email: email, password: password) { error, success, user in
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertFalse(success ?? true, "Login should fail")
            XCTAssertNil(user, "User should be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Test other scenarios such as network errors, etc.
}

