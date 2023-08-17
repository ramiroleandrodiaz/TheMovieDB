//
//  SearchShowsViewController.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 17/08/2023.
//

import Foundation
import UIKit
import SVPullToRefresh

class SearchShowsViewController: UIViewController {
    
    private lazy var dataSource: ShowListingDatasource = {
        let datasource = ShowListingDatasource(observer: self)
        return datasource
    }()
    
    private lazy var tvShowsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ShowListingCell.self, forCellReuseIdentifier: ShowListingCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.addInfiniteScrolling(actionHandler: {
            DispatchQueue.main.async {
                tableView.infiniteScrollingView.startAnimating()
            }
            self.dataSource.loadMoreShows()
        })
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blackTwo()
        self.view.addSubview(self.tvShowsTableView)
        self.setupConstraints()
        self.tvShowsTableView.dataSource = self.dataSource
        self.tvShowsTableView.delegate = self
        self.refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
    }
    
    @objc private func refreshTableView(_ sender: Any) {
        self.dataSource.loadShows()
     }
    
    func setupConstraints() {
        let tableViewConstraints = [
            self.tvShowsTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tvShowsTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tvShowsTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tvShowsTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
}

extension SearchShowsViewController: DataSourceObserver {
    func dataSourceUpdated() {
        DispatchQueue.main.async {[weak self] in
            self?.refreshControl.endRefreshing()
            self?.tvShowsTableView.infiniteScrollingView.stopAnimating()
            self?.tvShowsTableView.reloadData()
        }
    }
    
    func dataSourceFailed() {
        DispatchQueue.main.async {[weak self] in
            self?.refreshControl.endRefreshing()
            let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("An error ocurred retrieving the data", comment: "Error message"), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension SearchShowsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 196
    }
}
