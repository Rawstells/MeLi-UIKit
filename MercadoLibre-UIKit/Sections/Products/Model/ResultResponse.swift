//
//  ResultResponse.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 17/02/24.
//

import Foundation

class ProductResultResponse: Codable {
    var id: String
    var title: String
    var thumbnail: String
    var permalink: String
    var price: Double?
    var originalPrice: Double?

    init(id: String,
         title: String,
         thumbnail: String,
         permalink: String,
         price: Double? = nil,
         originalPrice: Double? = nil) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.permalink = permalink
        self.price = price
        self.originalPrice = originalPrice
    }

    var imageUrl: URL? { URL(string: thumbnail.replacingOccurrences(of: "http:", with: "https:") ) }
    
    var permalinkUrl: URL? { URL(string: permalink) }
    
    enum CodingKeys: String, CodingKey {
        case title, thumbnail, permalink, id, price, originalPrice = "original_price" //, discount
    }
}

extension ProductResultResponse: Equatable {
    static func == (lhs: ProductResultResponse, rhs: ProductResultResponse) -> Bool {
        lhs.id == rhs.id
    }
}
