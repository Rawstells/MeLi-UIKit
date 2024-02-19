//
//  ProductsRouter.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import UIKit

enum ProductsTransition {
    case showProductDescription(product: ProductResultResponse, products: [ProductResultResponse])
}

class ProductsRouter {
    
    // MARK: - Internal Properties
    
    var viewController: UIViewController?
    
    // MARK: - Internal Methods
    
    func handle(transition attendanceTransition: ProductsTransition) {
        switch attendanceTransition {
        case let .showProductDescription(product, products):
            showProductDescriptionViewController(product: product, products: products)
        }
        
    }
    
    // MARK: - Private Methods
    
    private func showProductDescriptionViewController(product: ProductResultResponse, products: [ProductResultResponse]) {
        guard let viewController = viewController else {
            return
        }
        ProductDetailFactory.showProductDescriptionViewController(from: viewController, product: product, products: products)
    }
    
}
