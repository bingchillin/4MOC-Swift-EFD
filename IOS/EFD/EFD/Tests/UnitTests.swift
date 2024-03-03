//
//  UnitTests.swift
//  EFDTests
//
//  Created by Mohamed El Fakharany on 01/03/2024.
//

import XCTest

@testable import EFD

//class CalculatorTests: XCTestCase {
//    var calculator: Calculator!
//
//    override func setUp() {
//        super.setUp()
//        calculator = Calculator()
//    }
//
//    override func tearDown() {
//        calculator = nil
//        super.tearDown()
//    }
//
//    func testAddition() {
//        XCTAssertEqual(calculator.add(2, 3), 5, "Adding 2 and 3 should result in 5")
//    }
//}

class ConnexionAPITests: XCTestCase {

//    func testConnexionAPI() throws {
//        let expectation = XCTestExpectation(description: "Test de connexion à l'API")
//
//        let apiUrlString = "http://localhost:3000"
//        guard let apiUrl = URL(string: apiUrlString) else {
//            XCTFail("URL de l'API invalide")
//            return
//        }
//
//        var request = URLRequest(url: apiUrl)
//        request.httpMethod = "GET"
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                XCTFail("Erreur lors de la connexion à l'API : \(error.localizedDescription)")
//            } else if let httpResponse = response as? HTTPURLResponse {
//                XCTAssertTrue((200...299).contains(httpResponse.statusCode), "Code de réponse HTTP invalide : \(httpResponse.statusCode)")
//                expectation.fulfill()
//            } else {
//                XCTFail("Réponse HTTP invalide")
//            }
//        }
//
//        task.resume()
//
//        wait(for: [expectation], timeout: 10.0)
//    }
}
