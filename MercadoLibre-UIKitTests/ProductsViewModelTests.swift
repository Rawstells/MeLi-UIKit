//
//  ProductsViewModelTests.swift
//  MercadoLibre-UIKitTests
//
//  Created by Joan Narvaez on 18/02/24.
//

@testable import MercadoLibre_UIKit
import XCTest

final class ProductsViewModelTests: XCTestCase {

    var sut: ProductsViewModel!
    var repository: ProductsRepositoryMock!

    override func setUp() {
        repository = ProductsRepositoryMock()
        sut = .init(repository: repository, router: .init())
    }

    func testGetProducts() async throws {
        // Given
        let expectedValue = ProductResponse(results: [ProductResultResponse(id: "1", title: "Carro", thumbnail: "", permalink: "")])
        repository.executeResult = expectedValue
        // When
        await sut.getProducts(product: "Carro")
        // Then
        XCTAssertEqual(expectedValue.results, sut.products)
    }

    func testGetProductsFailure() async throws {
        // Given
        let expectedValue = SearchProductViewModelOutput.errorMessage("Ha ocurrido un error, reintenta más tarde")
        repository.executeResult = nil
        // When
        await sut.getProducts(product: "Carro")
        // Then
        XCTAssertEqual(expectedValue, sut.outputEvents)
    }
}

extension ProductsViewModelTests {
    class ProductsRepositoryMock: ProductsRepositoryProtocol {
        var executeResult: ProductResponse!

        func getProducts(product: String) async throws -> [ProductResultResponse] {
            if let executeResult {
                return executeResult.results
            }
            throw URLError(.badServerResponse)
        }
    }
}
