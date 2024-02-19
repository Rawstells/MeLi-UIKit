//
//  ProductDetailViewModel.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import Foundation

class ProductDetailViewModel {
    
    // MARK: - Internal Properties
    
    var router: ProductDetailRouter
    
    // MARK: - Initializers
    
    init(router: ProductDetailRouter) {
        self.router = router

    }
    
    // MARK: - Private Methods
    
    func goToProductWebView(productUrl: URL) {
        router.handle(transition: .showProductWeb(productUrl: productUrl))
    }
    
}
