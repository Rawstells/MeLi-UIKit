//
//  RelatedCollectionViewAdapter.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 18/02/24.
//

import Combine
import UIKit

class RelatedCollectionViewAdapter: NSObject {
    
    // MARK: - Internal Properties
    
    var products: [ProductResultResponse] = []
    
    // MARK: - Internal Observable Properties
    
    var didSelectItemAt = PassthroughSubject<URL, Never>()
}

// MARK: - UICollectionViewDataSource
extension RelatedCollectionViewAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedCollectionViewCell.name, for: indexPath) as? RelatedCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.product = products[indexPath.row]
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RelatedCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 30, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productUrl = products[indexPath.row].permalinkUrl else { return }
        didSelectItemAt.send(productUrl)
    }
    
}
