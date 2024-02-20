//
//  ProductsViewModel.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 17/02/24.
//

import Foundation
import Combine

enum SearchProductViewModelOutput: Equatable {
    case none
    case didGetData([ProductResultResponse])
    case errorMessage(String)
}

class ProductsViewModel {
    @Published var products: [ProductResultResponse] = []
    @Published var outputEvents: SearchProductViewModelOutput = .none
    @Published var isLoading = false

    private var repository: ProductsRepositoryProtocol
    private var router: ProductsRouter

    init(repository: ProductsRepositoryProtocol,
          router: ProductsRouter) {
        self.repository = repository
        self.router = router
    }

    @MainActor
    func getProducts(product: String) async {
        do {
            let productResponse: [ProductResultResponse] = try await repository.getProducts(product: product)
            outputEvents = .didGetData(productResponse)
            products = productResponse
        } catch {
            outputEvents = .errorMessage("Ha ocurrido un error, reintenta más tarde")
        }
        isLoading = false
    }
    
    func goToProductDescription(product: ProductResultResponse, products: [ProductResultResponse]) {
        router.handle(transition: .showProductDescription(product: product, products: products))
    }
}
