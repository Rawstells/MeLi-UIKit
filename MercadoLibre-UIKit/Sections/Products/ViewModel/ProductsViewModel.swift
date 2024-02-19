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
    case isLoading(Bool)
    case didGetData([ProductResultResponse])
    case errorMessage(String)
}

class ProductsViewModel {
    @Published var products: [ProductResultResponse] = []
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorMessage: String = ""
    @Published var outputEvents: SearchProductViewModelOutput = .none
    
    private var apiManager: APIManagerProtocol
    private var router: ProductsRouter
        
    private var subscriptions: Set<AnyCancellable> = []
    private var debounceTimer: Timer?

    init(apiManager: APIManagerProtocol,
         router: ProductsRouter) {
        self.apiManager = apiManager
        self.router = router
    }

    /*var filteredProducts: [ProductResultResponse] {
        if text.isEmpty {
            return productResponse.results
        } else {
            return productResponse.results.filter { $0.title.contains(text.lowercased()) }
        }
    }*/
    
    @MainActor
    func getProducts(product: String) async {
        if !ApiTool.isConnected {
            //load()
            outputEvents = .isLoading(false)
            isLoading = false
            return
        }
        do {
            let productResponse: ProductResponse = try await apiManager.request(url: "https://api.mercadolibre.com/sites/MCO/search?q=\(product)", httpMethod: "GET", request: nil)
            outputEvents = .didGetData(productResponse.results)
            products = productResponse.results
        } catch {
            showError = true
            outputEvents = .errorMessage(error.localizedDescription)
            errorMessage = "Ha ocurrido un error, reintenta más tarde"
        }
        outputEvents = .isLoading(false)
        isLoading = false
        // save()
    }
    
    func search(text: String) {
        
            
        
    }
    
    func goToProductDescription(product: ProductResultResponse, products: [ProductResultResponse]) {
        router.handle(transition: .showProductDescription(product: product, products: products))
    }

   /* func load() {
        guard let data = UserDefaults.standard.data(forKey: "pokemons"),
              let savedTasks = try? JSONDecoder().decode(PokemonResponse.self, from: data) else {
            productResponse.results = []
            return
        }
        pokemonResponse = savedTasks
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(productResponse)
            UserDefaults.standard.set(data, forKey: "pokemons")
        } catch {
            print(error)
        }
    }
*/
}
