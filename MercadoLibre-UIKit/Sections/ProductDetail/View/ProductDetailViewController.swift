//
//  ProductDetailViewController.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import Combine
import UIKit

class ProductDetailViewController: UIViewController {
    
    // MARK: - Private UI properites
    
    private lazy var productDetailView: ProductDetailView = {
        let view = ProductDetailView()
        view.setCollectionViewDelegates(adapter, adapter)
        return view
    }()
    
    // MARK: - Internal Properties
    
    var product: ProductResultResponse? {
        didSet {
            productDetailView.product = product
        }
    }
    
    var products: [ProductResultResponse] = [] {
        didSet {
            updateTableView()
        }
    }
    
    // MARK: - Private Properties
    
    private var adapter = RelatedCollectionViewAdapter()
    private var subscriptions: Set<AnyCancellable> = []
    private var viewModel: ProductDetailViewModel
    
    // MARK: - Initializers
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle ViewController Methods
    
    override func loadView() {
        super.loadView()
        view = productDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Private Methods

    private func setupBindings() {
        productDetailView.onTapSeeMoreButton.sink { [unowned self] productUrl in
            viewModel.goToProductWebView(productUrl: productUrl)
        }.store(in: &subscriptions)

        adapter.didSelectItemAt.sink { [unowned self] productUrl in
            viewModel.goToProductWebView(productUrl: productUrl)
        }.store(in: &subscriptions)
    }
    
    private func updateTableView() {
        adapter.products = products.filter { $0.id != product?.id }
        productDetailView.reloadTableViewData()
    }
}
