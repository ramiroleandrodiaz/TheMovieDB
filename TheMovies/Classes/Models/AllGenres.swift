//
//  AllGenres.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 17/08/2023.
//

import Foundation

typealias GenreDict = [Int:String]

class AllGenres: Codable {

    enum CodingKeys: String, CodingKey {
        case genres
    }

    var genres: [Genre]?
    var genresDict: GenreDict

    init (genres: [Genre]?) {
        self.genres = genres
        self.genresDict = [:]
        self.genresDict = self.generateGenreDictionary(from: self.genres)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        genresDict = [:]
        genresDict = generateGenreDictionary(from: genres)
    }
    
    fileprivate func generateGenreDictionary(from genresParam: [Genre]?) ->  GenreDict {
        var dict: [Int:String] = [:]
        if let genres = genresParam {
            for genre in genres {
                if let id = genre.id, let name = genre.name, !name.isEmpty {
                    dict[id] = name
                }
            }
        }
        return dict
    }

}
