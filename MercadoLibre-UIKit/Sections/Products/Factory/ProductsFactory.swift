//
//  ProductsFactory.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import UIKit

enum ProductsFactory {
    
    static func getProductsViewController() -> ProductsViewController {
        // router
        let router = ProductsRouter()
        // repository
        let repository = ProductsRepository(apiManager: APIManager())
        // viewModel
        let viewModel = ProductsViewModel(repository: repository, router: router)
        // viewController
        let viewController = ProductsViewController(viewModel: viewModel)
        router.viewController = viewController
        return viewController
    }
    
    static func showProductsViewController(from originViewController: UIViewController) {
        let viewController = getProductsViewController()
        originViewController.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
