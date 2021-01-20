//
//  AllMoviesResponse.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit

// MARK: - AllMoviesResponse
class AllMoviesResponse: Codable {
    let page: Int?
    let movies: [Movie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
