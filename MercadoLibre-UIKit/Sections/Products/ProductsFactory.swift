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
        //let repository = ProductsRepository()
        // viewModel
        let viewModel = ProductsViewModel(apiManager: APIManager(), router: router)
        // viewController
        let viewController = ProductsViewController(viewModel: viewModel)
        
        router.viewController = viewController
        
        return viewController
    }
    
    /*static func showSearchProductViewController(from originViewController: UIViewController) {
        let viewController = getSearchProductViewController()
        originViewController.navigationController?.pushViewController(viewController, animated: true)
    }*/
    
}
