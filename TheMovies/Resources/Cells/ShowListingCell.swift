//
//  ShowListingCell.swift
//  TheMovies
//
//  Created by Ramiro Diaz on 16/08/2023.
//

import UIKit
import SDWebImage

class ShowListingCell: UITableViewCell {
    
    static let identifier = "ShowListingCell"
    
    let backgroundImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 3
        img.clipsToBounds = true
        img.backgroundColor = .slate()
        img.layer.compositingFilter = "luminosityBlendMode"
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let showNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.backgroundColor = .clear
        label.textColor = .iceBlue()
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.masksToBounds = false
        
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = .clear
        label.textColor = .white
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .dark()
        view.alpha = 0.8
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .darkSlate()
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI() {
        self.backgroundColor = .clear
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.backgroundImage)
        self.containerView.addSubview(self.showNameLabel)
        self.containerView.addSubview(self.genreContainer)
        self.genreContainer.addSubview(self.genreLabel)
        
        let imageConstraints = [
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.backgroundImage.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
        ]
        
        let labelConstraints = [
            self.showNameLabel.leadingAnchor.constraint(equalTo: self.backgroundImage.leadingAnchor, constant: 16),
            self.showNameLabel.trailingAnchor.constraint(equalTo: self.backgroundImage.trailingAnchor, constant: -16),
            self.showNameLabel.bottomAnchor.constraint(equalTo: self.backgroundImage.bottomAnchor, constant: -15)
        ]
        
        let genreContainerConstraints = [
            self.genreContainer.topAnchor.constraint(equalTo: self.backgroundImage.topAnchor, constant: 8),
            self.genreContainer.trailingAnchor.constraint(equalTo: self.backgroundImage.trailingAnchor, constant: -6),
            self.genreContainer.widthAnchor.constraint(equalTo: self.genreLabel.widthAnchor, constant: 30),
            self.genreContainer.heightAnchor.constraint(equalToConstant: 24)
        ]
        
        let genreLabelConstraints = [
            self.genreLabel.leadingAnchor.constraint(equalTo: self.genreContainer.leadingAnchor, constant: 15),
            self.genreLabel.trailingAnchor.constraint(equalTo: self.genreContainer.trailingAnchor, constant: -15),
            self.genreLabel.heightAnchor.constraint(equalToConstant: 15),
            self.genreLabel.centerYAnchor.constraint(equalTo: self.genreContainer.centerYAnchor)
        ]
        
        let containerViewConstraints = [
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.containerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.containerView.heightAnchor.constraint(equalToConstant: 156)
        ]
        
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(genreContainerConstraints)
        NSLayoutConstraint.activate(genreLabelConstraints)
    }

    
    fileprivate func fillLabels(name: String?, genreId: Int?, allGenres: GenreDict) {
        self.showNameLabel.text = name
        if let mainGenreId = genreId {
            if let genreName = allGenres[mainGenreId] {
                self.genreContainer.isHidden = false
                self.genreLabel.text = genreName
            } else {
                self.genreContainer.isHidden = true

            }
        } else {
            self.genreContainer.isHidden = true
        }
    }
    
    func configure(with show: Show, using genres: GenreDict) {
        self.fillLabels(name: show.name, genreId: show.genreIds?.first, allGenres: genres)
        if let path = show.backdropPath, !path.isEmpty {
            let urlString = ShowsConstants.NetworkURLs.imageBaseURL + path
            self.backgroundImage.sd_setImage(with: URL(string: urlString))
        }
        self.configureUI()
    }

}


