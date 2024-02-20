//
//  ProductWebViewController.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import Combine
import UIKit

class ProductWebViewController: UIViewController {

    // MARK: - Private UI properites
    
    private lazy var productWebView = ProductWebView()
        
    // MARK: - Internal Properties
    
    private var subscriptions: Set<AnyCancellable> = []
    
    var productUrl: URL? {
        didSet {
            productWebView.productUrl = productUrl
        }
    }
    
    override func loadView() {
        super.loadView()
        view = productWebView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Private Methods

    private func setupBindings() {
        productWebView.onTapCloseButton.sink { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }.store(in: &subscriptions)
    }
}
