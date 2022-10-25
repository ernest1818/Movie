// MovieListViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class MovieListViewCell: UITableViewCell {
    private enum Constants {
        static let imageUrl = "https://image.tmdb.org/t/p/w500"
        static var imageUrlTwo = ""
    }

    // MARK: - Private properties

    private let movieImageView = UIImageView()
    private let movieNameLabel = UILabel()
    private let descriptionLabel = UILabel()

    // MARK: - Life Cycles

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
    }

    // MARK: - Public Methods

    func movies(_ movie: Movies) {
        movieNameLabel.text = movie.title
        descriptionLabel.text = movie.overview
        Constants.imageUrlTwo = movie.posterPath
        let imageUrl = Constants.imageUrl + Constants.imageUrlTwo
        NetworkManager.downLoadImage(url: imageUrl) { image in
            self.movieImageView.image = image
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        createImageVIew()
        createNameLabel()
        createDiscriptionabel()
    }

    private func createImageVIew() {
        movieImageView.layer.cornerRadius = 15
        movieImageView.layer.masksToBounds = true
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)
        createImageViewAnchor()
    }

    private func createNameLabel() {
        movieNameLabel.backgroundColor = .red
        movieNameLabel.textAlignment = .center
        movieNameLabel.lineBreakMode = .byWordWrapping
        movieNameLabel.numberOfLines = 0
        movieNameLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieNameLabel)
        createNameLabelAnchor()
    }

    private func createDiscriptionabel() {
        descriptionLabel.backgroundColor = .red
        descriptionLabel.numberOfLines = 10
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        createDiscriptionLabelAnchor()
    }

    private func createImageViewAnchor() {
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        movieImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }

    private func createNameLabelAnchor() {
        movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        movieNameLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 40).isActive = true
        movieNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40).isActive = true
    }

    private func createDiscriptionLabelAnchor() {
        descriptionLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 16).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
    }
}
