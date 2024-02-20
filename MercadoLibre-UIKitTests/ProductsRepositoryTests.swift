//
//  ProductsRepositoryTests.swift
//  MercadoLibre-UIKitTests
//
//  Created by Joan Narvaez Ladino on 19/02/24.
//

@testable import MercadoLibre_UIKit
import XCTest

final class ProductsRepositoryTests: XCTestCase {

    var sut: ProductsRepository!
    var apiManager: APIManagerMock!

    override func setUp() {
        apiManager = APIManagerMock()
        sut = .init(apiManager: apiManager)
    }

    func testGetProducts() async throws {
        let expectedValue = ProductResponse(results: [ProductResultResponse(id: "1", title: "Carro", thumbnail: "", permalink: "")])
        apiManager.executeResult = expectedValue
        let products = try await sut.getProducts(product: "Carro")
        XCTAssertEqual(expectedValue.results, products)
    }
}

extension ProductsRepositoryTests {
    class APIManagerMock: APIManagerProtocol {

        var executeResult: ProductResponse!

        func request<T>(url: String, httpMethod: String, request: Encodable?) async throws -> T where T : Decodable {
            return executeResult as! T
        }
    }
}
