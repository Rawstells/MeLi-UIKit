//
//  ResultResponse.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 17/02/24.
//

import Foundation
import SwiftData

/*@Model
class ProductResultResponse: Codable, Identifiable {
    @Attribute(.unique)
    var id: String
    var title: String
    var thumbnail: String
    var price: Float?
    var original_price: Float?
    //var discount: String?
    

    var imageUrl: URL? { URL(string: thumbnail.replacingOccurrences(of: "http:", with: "https:") ) }

    enum CodingKeys: CodingKey {
        case title, thumbnail, id, price, original_price//, discount
    }

    init(id: String, title: String, thumbnail: String, price: Float?, original_price: Float?/*, discount: String? */) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.price = price
        self.original_price = original_price
       // self.discount = discount
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        id = try container.decode(String.self, forKey: .id)
        price = try container.decode(Float.self, forKey: .price)
        original_price = try container.decodeIfPresent(Float.self, forKey: .original_price)
       // discount = try container.decode(String.self, forKey: .discount)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(id, forKey: .id)
        try container.encode(price, forKey: .price)
        try container.encode(original_price, forKey: .original_price)
        //try container.encode(discount, forKey: .discount)
    }

}*/

class ProductResultResponse: Codable {
    var id: String
    var title: String
    var thumbnail: String
    var permalink: String
    var price: Double?
    var originalPrice: Double?
    
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
