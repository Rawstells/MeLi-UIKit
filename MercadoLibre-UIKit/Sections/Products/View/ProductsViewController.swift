//
//  ProductsViewController.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import Combine
import UIKit

class ProductsViewController: UIViewController {
    // MARK: - Private UI properites
    
    private lazy var searchProductView: ProductsView = {
        let view = ProductsView()
        view.setTableViewDelegates(adapter, adapter)
        return view
    }()
    
    // MARK: - Private Properties
    
    private var adapter = SearchProductAdapter()
    private var viewModel: ProductsViewModel
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Initializers
    
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle ViewController Methods
    
    override func loadView() {
        super.loadView()
        view = searchProductView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupBindings()
    }

    // MARK: - Private Methods
    
    private func setupBindings() {
        adapter.didSelectItemAt.sink { [unowned self] product, products in
            self.goToProductDescription(product: product, products: products)
        }.store(in: &subscriptions)

        // viewModel to View
        viewModel.$outputEvents.dropFirst().sink { [weak self] event in
            self?.validateEvents(event: event)
        }.store(in: &subscriptions)
        
        // view To viewModel
        searchProductView.publicSearchProductTextField.textPublisher
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.viewModel.outputEvents = .didGetData([])
                    self.viewModel.outputEvents = .isLoading(false)
                    return nil
                }
                
                if !self.isLoading { self.viewModel.outputEvents = .isLoading(true) }
                
                return string
            })
            .compactMap { $0 }
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { text in
                Task { await self.viewModel.getProducts(product: text) }
            }).store(in: &subscriptions)
    }
    
    private func validateEvents(event: SearchProductViewModelOutput) {
        switch event {
        case .isLoading(let isLoading):
            if isLoading {
                showSpinner(onView: view)
            } else {
                removeSpinner()
            }
        case .didGetData(let products):
            updateTableView(products: products)
        case .errorMessage(let error):
            showAlert(error: error)
        case .none:
            break
        }
    }
    
    private func updateTableView(products: [ProductResultResponse]) {
        adapter.products = products
        searchProductView.reloadTableViewData()
    }
    
    private func goToProductDescription(product: ProductResultResponse, products: [ProductResultResponse]) {
        viewModel.goToProductDescription(product: product, products: products)
    }
}
