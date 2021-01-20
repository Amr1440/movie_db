//
//  AllMoviesRequestParamters.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit

class AllMoviesRequestParamters: BaseRequestParamters {
    var page: Int?

    private enum CodingKeys: String, CodingKey {
        case page
        case api_key = "api_key"
    }

    init(page: Int) {
        super.init()
        self.page = page
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(api_key, forKey: .api_key)
    }
}
