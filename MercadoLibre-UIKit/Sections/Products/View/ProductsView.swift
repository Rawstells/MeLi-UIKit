//
//  ProductsView.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import UIKit

class ProductsView: UIView {

    // MARK: - Private UI Properties
    
    private var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.backgroundColor = .yellow
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var searchProductTextField: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Search"
        return textfield
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: ProductsTableViewCell.name)
        return tableView
    }()
    
    var publicSearchProductTextField: UITextField { searchProductTextField }
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        addSubViews()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func setTableViewDelegates(_ delegate: UITableViewDelegate, _ datasource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = datasource
    }

    func reloadTableViewData() {
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(searchProductTextField)
        containerStackView.addArrangedSubview(tableView)
        
        addConstraints()
    }
    
    private func addConstraints() {
        // containerStackView
        containerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // searchProductTextField
        searchProductTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchProductTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        searchProductTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        searchProductTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }

}
