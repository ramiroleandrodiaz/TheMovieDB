//
//  AllShows.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 16/08/2023.
//

import Foundation

class AllShows: Codable {

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case shows = "results"
        case page
    }

    var totalPages: Int?
    var totalResults: Int?
    var shows: [Show]?
    var page: Int?

    init (totalPages: Int?, totalResults: Int?, shows: [Show]?, page: Int?) {
        self.totalPages = totalPages
        self.totalResults = totalResults
        self.shows = shows
        self.page = page
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
        shows = try container.decodeIfPresent([Show].self, forKey: .shows)
        page = try container.decodeIfPresent(Int.self, forKey: .page)
    }

}
