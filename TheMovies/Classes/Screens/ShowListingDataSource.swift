//
//  ShowListingDataSource.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 16/08/2023.
//

import Foundation
import UIKit

class ShowListingDatasource: NSObject {
    // This datasource handles the API calls and populates the shows tableview with the data obtained.
    // In this class we also pre-fetch all the genres at the beggining so we can easily match them later.
    
    weak var observer: DataSourceObserver?
    var shows: [Show]
    var genres: GenreDict
    private var page: Int = 1
    
    init(observer: DataSourceObserver? = nil) {
        self.observer = observer
        self.shows = []
        self.genres = [:]
        
        super.init()
        
        self.loadGenres()
        self.loadShows()
    }
    
    // MARK: - API Calls
    
    func loadGenres() {
        NetworkManager.shared.getGenres(onSuccess: { [weak self] (fetchedGenres) in
            self?.genres = fetchedGenres.genresDict
        }, onFailed: { (message) in
            print(message ?? "Error fetching genres")
        })
    }
    
    func loadShows() {
        NetworkManager.shared.getTopRatedShows(page: 1, onSuccess: { [weak self] (fetchedShows) in
            guard let self = self else { return }
            self.page = 1
            self.shows = fetchedShows.shows ?? []
            self.observer?.dataSourceUpdated()
        }, onFailed: { (message) in
            print(message ?? "Error fetching shows")
        })
    }
    
    func loadMoreShows() {
        NetworkManager.shared.getTopRatedShows(page: self.page + 1, onSuccess: { [weak self] (fetchedShows) in
            guard let self = self else { return }
            self.page += 1
            self.shows += fetchedShows.shows ?? []
            self.observer?.dataSourceUpdated()
        }, onFailed: { (message) in
            print(message ?? "Error fetching more shows")
        })
    }
}

// MARK: - TableView Methods

extension ShowListingDatasource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowListingCell.identifier, for: indexPath) as! ShowListingCell
        let show = shows[indexPath.row]
        cell.configure(with: show, using: genres)
        return cell
    }
    
}
