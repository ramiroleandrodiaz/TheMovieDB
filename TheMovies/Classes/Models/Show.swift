//
//  Show.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 14/08/2023.
//

import Foundation
import UIKit

class Show: Codable {
    // Basic Show Class, implementing codable protocol to easily decode it from JSON
    
    enum CodingKeys: String, CodingKey {
        case genreIds = "genre_ids"
        case firstAir = "first_air_date"
        case id
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case overview
        case adult
        case video
        case posterPath = "poster_path"
        case popularity
        case name
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }

    var genreIds: [Int]?
    var firstAir: String?
    var id: Int?
    var originalTitle: String?
    var originalLanguage: String?
    var voteCount: Int?
    var overview: String?
    var adult: Bool?
    var video: Bool?
    var posterPath: String?
    var popularity: Float?
    var name: String?
    var backdropPath: String?
    var voteAverage: Float?

    init (genreIds: [Int]?, firstAir: String?, id: Int?, originalTitle: String?, originalLanguage: String?, voteCount: Int?, overview: String?, adult: Bool?, video: Bool?, posterPath: String?, popularity: Float?, name: String?, backdropPath: String?, voteAverage: Float?) {
        self.genreIds = genreIds
        self.firstAir = firstAir
        self.id = id
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.voteCount = voteCount
        self.overview = overview
        self.adult = adult
        self.video = video
        self.posterPath = posterPath
        self.popularity = popularity
        self.name = name
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds)
          firstAir = try container.decodeIfPresent(String.self, forKey: .firstAir)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        video = try container.decodeIfPresent(Bool.self, forKey: .video)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        popularity = try container.decodeIfPresent(Float.self, forKey: .popularity)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage)
    }
}
