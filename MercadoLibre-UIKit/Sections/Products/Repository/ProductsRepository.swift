//
//  ProductsRepository.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 19/02/24.
//

import Foundation

protocol ProductsRepositoryProtocol {
    func getProducts(product: String) async throws -> [ProductResultResponse]
}

struct ProductsRepository: ProductsRepositoryProtocol {
    private let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }

    func getProducts(product: String) async throws -> [ProductResultResponse] {
        if !ApiTool.isConnected { throw URLError(.notConnectedToInternet) }
        let url = "https://api.mercadolibre.com/sites/MCO/search?q=\(product)"
        let productResponse: ProductResponse = try await apiManager.request(url: url, httpMethod: "GET", request: nil)
        return productResponse.results
    }
}
