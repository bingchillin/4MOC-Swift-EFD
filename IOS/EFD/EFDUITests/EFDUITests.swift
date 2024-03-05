//
//  EFDUITests.swift
//  EFDUITests
//
//  Created by Mohamed El Fakharany on 05/03/2024.
//

import XCTest

final class EFDUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUILogin() throws {
        let app = XCUIApplication()
        app.launch()
        
        let usernameTextField = app.textFields["userTextFieldIdentifier"]
        let passwordTextField = app.secureTextFields["passwordTextFieldIdentifier"]
        let loginButton = app.buttons["loginButtonIdentifier"]

        XCTAssertTrue(usernameTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(loginButton.exists)

        usernameTextField.tap()
        usernameTextField.typeText("ezezez")
        
        passwordTextField.tap()
        passwordTextField.typeText("ezezez")

        loginButton.tap()

        let welcomeMessage = app.staticTexts["welcomeLabelIdentifier"]
        XCTAssertTrue(welcomeMessage.waitForExistence(timeout: 10))
    }
}
