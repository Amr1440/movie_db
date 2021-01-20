//
//  Movie.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit
import RealmSwift

// MARK: - Movie
class Movie: Object, Codable {
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var originalTitle, overview: String?
    @objc dynamic var posterPath, releaseDate, title: String?
    @objc dynamic var genres: [Genre]?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override class func ignoredProperties() -> [String] {
        return ["genres"]
    }
    
    enum CodingKeys: String, CodingKey {
        case adult, genres
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.title = try container.decode(String.self, forKey: .title)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        if container.contains(.genres) {
            self.genres = try container.decode([Genre].self, forKey: .genres)
        }
        
    }
}


// MARK: - Genre
@objc class Genre: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
}
