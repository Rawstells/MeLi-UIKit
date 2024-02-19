//
//  ProductsTableViewCell.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    static let name = String(describing: ProductsTableViewCell.self)

    // MARK: - Private UI Properties
    
    private var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.withRoundedBorders(withBorder: true)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    // MARK: - Internal Properties
    
    var product: ProductResultResponse? {
        didSet {
            setupProduct()
        }
    }
    
    // MARK: - Private Properties
    
    private var imageService = ImageService()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)

        addConstraints()
    }
    
    private func addConstraints() {
        // productImageView
        productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        // titleLabel
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        // priceLabel
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 15).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    }
    
    private func setupProduct() {
        guard let product else { return }
        titleLabel.text = product.title
        priceLabel.text = "$ \(product.price ?? 0) COP"
        setupImage(url: product.imageUrl)
    }
    
    private func setupImage(url: URL?) {
        guard let url else { return }
        imageService.image(for: url) { image in
            self.productImageView.image = image
        }
    }

}
