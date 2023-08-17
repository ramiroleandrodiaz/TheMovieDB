//
//  NetworkManager.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 14/08/2023.
//

import Foundation
import Alamofire

typealias onFailed = (_ message: String?) -> ()

class NetworkManager {
    
    static let shared = NetworkManager()
    
    fileprivate let headers: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjIwMmZkZTkzYzcyNzU0NjUwYTdjNmU3MjcyMjJiOSIsInN1YiI6IjY0ZDk2N2FlNjNhYWQyMDExZGYzYmM5NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eRYknYiNVX-X4tA464YQ86G0ZQCykh-nhmOcy2gq1mY",
        "Accept": "application/json"
    ]
        
    private init() {}
    
    func getGenres(onSuccess: @escaping (_ result: AllGenres) -> Void, onFailed: @escaping onFailed) {
        
        let baseParams: [String:Any] = [ShowsConstants.QueryDefaults.language : ShowsConstants.QueryDefaults.english]
        let finalUrl = ShowsConstants.NetworkURLs.baseURL + ShowsConstants.NetworkURLs.genresUrl
        
        AF.request(finalUrl, method: .get, parameters: baseParams, encoding: URLEncoding.default, headers: headers, interceptor: nil).response { (response) in
            switch response.result {
            case .failure(let error):
                onFailed(error.errorDescription)
            case .success(let data):
                do {
                    let allGenres = try JSONDecoder().decode(AllGenres.self, from: data ?? Data())
                    onSuccess(allGenres)
                } catch {
                    onFailed("Error decoding genres")
                }
            }
        }
    }
        
    func getTopRatedShows(page: Int, onSuccess: @escaping (_ result: AllShows) -> Void, onFailed: @escaping onFailed)  {
        let baseParams: [String:Any] = [ShowsConstants.QueryDefaults.language : ShowsConstants.QueryDefaults.english,
                                       ShowsConstants.QueryDefaults.page : page]
        let finalUrl = ShowsConstants.NetworkURLs.baseURL + ShowsConstants.NetworkURLs.topRatedTvShowsUrl
        
        AF.request(finalUrl, method: .get, parameters: baseParams, encoding: URLEncoding.default, headers: headers, interceptor: nil).response { (response) in
            switch response.result {
            case .failure(let error):
                onFailed(error.errorDescription)
            case .success(let data):
                do {
                    let allShows = try JSONDecoder().decode(AllShows.self, from: data ?? Data())
                    onSuccess(allShows)
                } catch {
                    onFailed("Error decoding shows")
                }
            }
        }
    }
    
    func searchMultiShows(page: Int, query: String) {
        
    }
}
