//
//  MovieTemp.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit

class MovieTemp: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let originalTitle, overview: String?
    let posterPath, releaseDate, title: String?
//    let genres: [GenreTemp]?
}

// MARK: - Genre
class GenreTemp: Codable {
    let id: Int?
    let name: String?
}
