//
//  RelatedTableViewCell.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import Combine
import UIKit

class RelatedTableViewCell: UITableViewCell {
    
    static let name = String(describing: RelatedTableViewCell.self)

    // MARK: - Private UI Properties
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
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
    
    var products: [ProductResultResponse] = [] {
        didSet {
            updateCollectionView()
        }
    }
    
    // MARK: - Internal Observable Properties
    
    var didSelectItemAt = PassthroughSubject<URL, Never>()
    
    // MARK: - Private Properties
    
    private var adapter = RelatedCollectionViewAdapter()
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        contentView.addSubview(collectionView)

        addConstraints()
    }
    
    private func addConstraints() {
        // collectionView
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setupBindings() {
        adapter.didSelectItemAt.sink { [unowned self] productUrl in
            self.didSelectItemAt.send(productUrl)
        }.store(in: &subscriptions)
    }
    
    private func updateCollectionView() {
        adapter.products = products
        collectionView.reloadData()
    }

}
