//
//  EFDTests.swift
//  EFDTests
//
//  Created by Mohamed El Fakharany on 01/03/2024.
//

import XCTest

@testable import EFD

final class EFDTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSuccessfulLogin() throws {
        let email = "ezezez"
        let password = "ezezez"

            ConnexionWebServices.connectUser(email: email, password: password) { error, success, user in
            XCTAssertTrue(success ?? false, "Login should succeed")
        }
    }

    func testConnexionAPI() throws {
        let expectation = XCTestExpectation(description: "Test de connexion à l'API")

        let apiUrlString = "http://localhost:3000"
        guard let apiUrl = URL(string: apiUrlString) else {
            XCTFail("URL de l'API invalide")
            return
        }

        var request = URLRequest(url: apiUrl)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                XCTFail("Erreur lors de la connexion à l'API : \(error.localizedDescription)")
            } else if let httpResponse = response as? HTTPURLResponse {
                XCTAssertTrue((200...299).contains(httpResponse.statusCode), "Code de réponse HTTP invalide : \(httpResponse.statusCode)")
                expectation.fulfill()
            } else {
                XCTFail("Réponse HTTP invalide")
            }
        }

        task.resume()

        wait(for: [expectation], timeout: 10.0)
    }
}
