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
            static let tableViewSectionTitle: String = "Top Rated Shows"
        }
        
        struct ShowDetail {
            static let overview: String = "Overview"
            static let subscribeButtonTitle: String = "Subscribe"
        }
    }
    
    struct Fonts {
        static let tableViewSectionHeaderFont: UIFont = UIFont(name: "ProximaNovaSoft-Medium", size: 12) ?? UIFont.boldSystemFont(ofSize: 12)
    }
    
    struct Images {
        static let backIcon = UIImage(named: "BackIcon")!
    }
}
