//
//  ProductDetailRouter.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import UIKit

enum ProductDetailRouterTransition {
    case showProductWeb(productUrl: URL)
}

class ProductDetailRouter {
    
    // MARK: - Internal Properties
    
    var viewController: UIViewController?
    
    // MARK: - Internal Methods
    
    func handle(transition attendanceTransition: ProductDetailRouterTransition) {
        switch attendanceTransition {
        case let .showProductWeb(productUrl):
            showProductWebViewController(productUrl: productUrl)
        }
        
    }
    
    // MARK: - Private Methods
    
    private func showProductWebViewController(productUrl: URL) {
        guard let viewController = viewController else {
            return
        }
        ProductWebFactory.showProductWebViewController(from: viewController, productUrl: productUrl)
    }
    
}
