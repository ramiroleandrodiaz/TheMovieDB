//
//  ShowsConstants.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 14/08/2023.
//

import Foundation
import Alamofire

protocol DataSourceObserver: NSObject {
    func dataSourceUpdated()
    func dataSourceFailed()
}

class ShowsConstants {
    
    struct NetworkURLs {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let imageBaseURL = "https://image.tmdb.org/t/p/original"
        static let topRatedTvShowsUrl = "tv/top_rated"
        static let genresUrl = "genre/tv/list"
    }
    
    
    public enum QueryDefaults {
        static let language: String = "language"
        static let english: String = "en"
        static let page: String  = "page"
    }
    
    struct Strings {
        struct Main {
            
        }
        
        struct MovieDetail {
            
        }
    }
}
