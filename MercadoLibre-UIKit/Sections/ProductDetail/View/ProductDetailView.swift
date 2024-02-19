//
//  ProductDetailView.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import Combine
import UIKit

class ProductDetailView: UIView {

    // MARK: - Private UI Properties
    
    private var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private var nameProductLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.withRoundedBorders(withBorder: true)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var priceProductLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 35, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ver más", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(seeMoreButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var relatedProductLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Productos relacionados"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(RelatedCollectionViewCell.self, forCellWithReuseIdentifier: RelatedCollectionViewCell.name)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 10)
        return layout
    }()
    
    // MARK: - Internal Properties
    
    var product: ProductResultResponse? {
        didSet {
            setupView()
        }
    }
    
    // MARK: - Private Properties
    
    private var imageService = ImageService()
    
    // MARK: - Internal Observable Properties
    
    var onTapSeeMoreButton = PassthroughSubject<URL, Never>()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func setCollectionViewDelegates(_ delegate: UICollectionViewDelegate, _ datasource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
    }

    func reloadTableViewData() {
        collectionView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(nameProductLabel)
        containerStackView.addArrangedSubview(productImageView)
        containerStackView.addArrangedSubview(priceProductLabel)
        containerStackView.addArrangedSubview(seeMoreButton)
        containerStackView.addArrangedSubview(relatedProductLabel)
        addSubview(collectionView)
        
        addConstraints()
    }
    
    private func addConstraints() {
        // containerStackView
        containerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        // nameProductLabel
        nameProductLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nameProductLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        nameProductLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        // productImageView
        productImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        productImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        // seeMoreButton
        seeMoreButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        // tableView
        collectionView.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 10).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    @objc
    private func seeMoreButtonAction(sender: UIButton!) {
        guard let imageUrl = product?.permalinkUrl else { return }
        onTapSeeMoreButton.send(imageUrl)
    }
    
    private func setupView() {
        guard let product else { return }
        nameProductLabel.text = product.title
        priceProductLabel.text = "$ \(product.price ?? 0) COP"
        setupImage(url: product.imageUrl)
    }
    
    private func setupImage(url: URL?) {
        guard let url else { return }
        imageService.image(for: url) {
            self.productImageView.image = $0
        }
    }
    
}
