//
//  AllGenres.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 17/08/2023.
//

import Foundation

typealias GenreDict = [Int:String]
// Created this dictionary for easy searching and in an efficient way, instead of finding in [Genre] array.
// Searching in Dictionanry is similar to searching in hash tables, so its very performant (close to O(1)).

class AllGenres: Codable {
    // This class contains all genres, like all shows is what we get from the API, a collection of genres, and its easily mapped this way.
    // Also this class maps the array into a dictionary for searching (with genreID as key) purposes.
    
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
