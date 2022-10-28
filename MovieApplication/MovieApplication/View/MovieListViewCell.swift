// MovieListViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class MovieListViewCell: UITableViewCell {
    private enum Constants {
        static let imageUrl = "https://image.tmdb.org/t/p/w200"
        static var imageUrlTwo = ""
    }

    // MARK: - Visual Components

    private let movieImageView = UIImageView()
    private let movieNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let voteAverageLabel = UILabel()

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
        voteAverageLabel.text = "\(movie.voteAverage)"
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
        createAvarageLabel()
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
        movieNameLabel.textAlignment = .center
        movieNameLabel.lineBreakMode = .byWordWrapping
        movieNameLabel.numberOfLines = 0
        movieNameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieNameLabel)
        createNameLabelAnchor()
    }

    private func createDiscriptionabel() {
        descriptionLabel.numberOfLines = 10
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        createDiscriptionLabelAnchor()
    }

    private func createAvarageLabel() {
        voteAverageLabel.backgroundColor = .systemOrange
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        voteAverageLabel.layer.cornerRadius = 5
        voteAverageLabel.layer.masksToBounds = true
        voteAverageLabel.textAlignment = .center
        voteAverageLabel.font = .systemFont(ofSize: 15, weight: .bold)
        movieImageView.addSubview(voteAverageLabel)
        createAvarageLabelAnchor()
    }

    private func createAvarageLabelAnchor() {
        voteAverageLabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -5).isActive = true
        voteAverageLabel.rightAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: -5).isActive = true
        voteAverageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        voteAverageLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
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
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
}
