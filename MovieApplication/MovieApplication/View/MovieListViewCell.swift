// MovieListViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class MovieListViewCell: UITableViewCell {
    // MARK: - Private properties

    private let movieImageView = UIImageView()
    private let movieNameLabel = UILabel()
    private let discriptionLabel = UILabel()
    private var movies: Movies?

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
        movies = movie
        movieNameLabel.text = movie.title
    }

    // MARK: - Private Methods

    private func setupUI() {
        createImageVIew()
        createNameLabel()
        createDiscriptionabel()
    }

    private func createImageVIew() {
        movieImageView.backgroundColor = .purple
        movieImageView.layer.cornerRadius = 15
        movieImageView.layer.masksToBounds = true
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)
        createImageViewAnchor()
    }

    private func createNameLabel() {
        movieNameLabel.backgroundColor = .red
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieNameLabel)
        createNameLabelAnchor()
    }

    private func createDiscriptionabel() {
        discriptionLabel.backgroundColor = .red
        discriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(discriptionLabel)
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
        movieNameLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 50).isActive = true
        movieNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50).isActive = true
        movieNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func createDiscriptionLabelAnchor() {
        discriptionLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 16).isActive = true
        discriptionLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 16).isActive = true
        discriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        discriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
}
