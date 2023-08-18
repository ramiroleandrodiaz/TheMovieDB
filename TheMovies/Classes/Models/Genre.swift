//
//  Genre.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 17/08/2023.
//

import Foundation

class Genre: Codable {
    // Basic Genre class. Single genre contains id and name. Implementing Codable & Decoding.
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    var id: Int?
    var name: String?


    init (id: Int?, name: String?) {
        self.id = id
        self.name = name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}
