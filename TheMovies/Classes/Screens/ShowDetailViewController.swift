//
//  ShowDetailViewController.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 17/08/2023.
//

import Foundation
import UIKit

class ShowDetailViewController: UIViewController {
    
    var show: Show?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var backgroundPosterView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.compositingFilter = "luminosityBlendMode"
        imageView.alpha = 0.1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var mainPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 4.0
        imageView.layer.shadowOpacity = 1.0
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.masksToBounds = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    private lazy var overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ShowsConstants.Strings.ShowDetail.overview.uppercased()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .overviewBlack()
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subscribeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(ShowsConstants.Strings.ShowDetail.subscribeButtonTitle, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        button.tintColor = .white
        button.layer.cornerRadius = 24  // Suggested radius in zeplin was 100, broke the design.
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return button
    }()
      
    override func viewDidLoad() {
        self.view.backgroundColor = .detailBackgroundColor()
        setupBackgroundImageConstraints()
        setupContentViewConstraints()
        setupScrollViewContstraints()
        setupMainPosterItemImageViewConstraints()
        setupDescriptionLabelsConstraints()
        setupBackButtonViewConstraints()
        setupShowInfo()
        setupUI()
    }
    
    private func setupShowInfo() {
        
        if let path = self.show?.backdropPath, !path.isEmpty {
            let urlString = ShowsConstants.NetworkURLs.imageBaseURL + path
            self.backgroundPosterView.sd_setImage(with: URL(string: urlString))
        }
        
        if let path = self.show?.posterPath, !path.isEmpty {
            let urlString = ShowsConstants.NetworkURLs.imageBaseURL + path
            self.mainPosterImageView.sd_setImage(with: URL(string: urlString))
        }
        
        self.titleLabel.text = self.show?.name
        self.dateLabel.text = self.show?.firstAir
        self.overviewInfoLabel.text = self.show?.overview
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let labelHeight = self.overviewInfoLabel.frame.height
        NSLayoutConstraint.activate([self.contentView.heightAnchor.constraint(equalToConstant: 600 + labelHeight)])
    }
    
    func setupUI() {
        self.backButton.setImage(ShowsConstants.Images.backIcon, for: UIControl.State())
    }
    
    private func setupScrollViewContstraints() {
        self.view.addSubview(scrollView)
        let scrollViewConstraints = [
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
    }

    private func setupContentViewConstraints() {
        self.scrollView.addSubview(self.contentView)
        let contentViewConstraints = [
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.heightAnchor.constraint(equalToConstant: 2000)
        ]
        NSLayoutConstraint.activate(contentViewConstraints)
    }
    
    private func setupBackgroundImageConstraints() {
        self.view.addSubview(self.backgroundPosterView)
        let backgroundImageConstraints = [
            self.backgroundPosterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundPosterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundPosterView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundPosterView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(backgroundImageConstraints)
    }
    
    private func setupBackButtonViewConstraints() {
        self.view.addSubview(self.backButton)
        let backButtonConstraints = [
            self.backButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 13),
            self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 25),
            self.backButton.widthAnchor.constraint(equalToConstant: 38),    // I incremented the suggested size in zeplin (28) because it was too small.
            self.backButton.heightAnchor.constraint(equalToConstant: 38)
        ]
        NSLayoutConstraint.activate(backButtonConstraints)
    }

    private func setupMainPosterItemImageViewConstraints() {
        self.contentView.addSubview(self.mainPosterImageView)
        let mainPosterConstraints = [
            self.mainPosterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 43),
            self.mainPosterImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.mainPosterImageView.widthAnchor.constraint(equalToConstant: 182),
            self.mainPosterImageView.heightAnchor.constraint(equalToConstant: 273)
        ]
        NSLayoutConstraint.activate(mainPosterConstraints)
    }

    private func setupDescriptionLabelsConstraints() {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.subscribeButton)
        self.contentView.addSubview(self.overviewTitleLabel)
        self.contentView.addSubview(self.overviewInfoLabel)
        
        let titleLabelConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.mainPosterImageView.bottomAnchor, constant: 23),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        let dateLabelConstraints = [
            self.dateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.dateLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ]
        NSLayoutConstraint.activate(dateLabelConstraints)
        
        let subscribeButtonConstraints = [
            self.subscribeButton.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 22),
            self.subscribeButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.subscribeButton.heightAnchor.constraint(equalToConstant: 45),
            self.subscribeButton.widthAnchor.constraint(equalToConstant: 195)
        ]
        NSLayoutConstraint.activate(subscribeButtonConstraints)
        
        let overviewTitleLabelConstraints = [
            self.overviewTitleLabel.topAnchor.constraint(equalTo: self.subscribeButton.bottomAnchor, constant: 43),
            self.overviewTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 37),
            self.overviewTitleLabel.heightAnchor.constraint(equalToConstant: 24)
        ]
        NSLayoutConstraint.activate(overviewTitleLabelConstraints)
        
        let overviewInfoLabelConstraints = [
            self.overviewInfoLabel.topAnchor.constraint(equalTo: self.overviewTitleLabel.bottomAnchor, constant: 22),
            self.overviewInfoLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 37),
            self.overviewInfoLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -37)
        ]
        NSLayoutConstraint.activate(overviewInfoLabelConstraints)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
