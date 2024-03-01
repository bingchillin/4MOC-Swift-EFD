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
        XCTAssertEqual(calculator.add(2, 3), 6, "Adding 2 and 3 should result in 5")
    }
}

