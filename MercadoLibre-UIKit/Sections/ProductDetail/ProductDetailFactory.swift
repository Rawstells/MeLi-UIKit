//
//  ProductDetailFactory.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import UIKit

enum ProductDetailFactory {
    
    static func getProductDescriptionViewController(product: ProductResultResponse, products: [ProductResultResponse]) -> ProductDetailViewController {
        // router
        let router = ProductDetailRouter()
        // viewModel
        let viewModel = ProductDetailViewModel(router: router)
        // viewController
        let viewController = ProductDetailViewController(viewModel: viewModel)
        viewController.product = product
        viewController.products = products
        router.viewController = viewController
        
        return viewController
    }
    
    static func showProductDescriptionViewController(from originViewController: UIViewController, product: ProductResultResponse, products: [ProductResultResponse]) {
        let viewController = getProductDescriptionViewController(product: product, products: products)
        originViewController.navigationController?.present(viewController, animated: true)
    }
    
}
