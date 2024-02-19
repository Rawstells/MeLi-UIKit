//
//  ProductWebFactory.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 17/02/24.
//

import UIKit

enum ProductWebFactory {
    
    static func getProductWebViewController(productUrl: URL) -> ProductWebViewController {
        // viewController
        let viewController = ProductWebViewController()
        viewController.productUrl = productUrl
        return viewController
    }
    
    static func showProductWebViewController(from originViewController: UIViewController, productUrl: URL) {
        let viewController = getProductWebViewController(productUrl: productUrl)
        originViewController.present(viewController, animated: true, completion: nil)
    }
    
}
