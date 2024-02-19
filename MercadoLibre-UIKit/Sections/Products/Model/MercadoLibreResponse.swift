//
//  MercadoLibreResponse.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 17/02/24.
//

import Foundation
import SwiftData

//@Model
final class ProductResponse: Codable {
    var results: [ProductResultResponse]

    enum CodingKeys: CodingKey {
        case results
    }

    init(results: [ProductResultResponse]) {
        self.results = results
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([ProductResultResponse].self, forKey: .results)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
    }
}

extension ProductResponse: Equatable {
    static func == (lhs: ProductResponse, rhs: ProductResponse) -> Bool {
        lhs.results == rhs.results
    }
}
