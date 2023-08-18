//
//  ShowsAndSuscriptionsViewController.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 14/08/2023.
//

import Foundation
import UIKit
import SVPullToRefresh

class ShowsAndSuscriptionsViewController: UIViewController {
    // Main View controller (root in navigation) that displays shows (top rated) and subscriptions.
    
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
        tableView.allowsSelection = true
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
        self.setUpConstraintsAndUI()
        setupTableViewSources()
    }
    
    @objc private func refreshTableView(_ sender: Any) {
        self.dataSource.loadShows()
     }
    
    func setupTableViewSources() {
        self.tvShowsTableView.dataSource = self.dataSource
        self.tvShowsTableView.delegate = self
        self.refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
    }
    
    // MARK: - Layout Constraints
    
    func setUpConstraintsAndUI() {
        self.view.backgroundColor = .blackTwo()
        self.view.addSubview(self.tvShowsTableView)
        self.navigationController?.isNavigationBarHidden = true
        
        let tableViewConstraints = [
            self.tvShowsTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tvShowsTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tvShowsTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tvShowsTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
}

// MARK: - DataSource Observer

extension ShowsAndSuscriptionsViewController: DataSourceObserver {
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

// MARK: - TableViewDelegate

extension ShowsAndSuscriptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 196
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView.init(frame: CGRectMake(0, 0, tableView.frame.width, 45))
        headerView.backgroundColor = UIColor.clear

        let labelView: UILabel = UILabel.init(frame: CGRectMake(20, 0, tableView.frame.width, 12))
        labelView.text = ShowsConstants.Strings.Main.tableViewSectionTitle
        labelView.font = ShowsConstants.Fonts.tableViewSectionHeaderFont
        labelView.textColor = .white
        labelView.backgroundColor = .blackTwo()
        labelView.layer.opacity = 0.56
        
        headerView.addSubview(labelView)
        
        let labelConstraints = [
            labelView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            labelView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(labelConstraints)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedShow = self.dataSource.shows[safe: indexPath.row] {
            let detailViewController = ShowDetailViewController()
            detailViewController.show = selectedShow
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
