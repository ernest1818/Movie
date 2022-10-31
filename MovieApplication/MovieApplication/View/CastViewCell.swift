// CastViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Ячейка с актерами
final class CastViewCell: UICollectionViewCell {
    private enum Constants {
        static let imageURL = "https://image.tmdb.org/t/p/w500"
    }

    // MARK: - Private Visual Component

    private let castImageView = UIImageView()
    private let castLabel = UILabel()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func updateInfo(info: Cast) {
        castLabel.text = info.originalName
        let imageURL = Constants.imageURL + (info.profilePath ?? "")
        NetworkManager.downLoadImage(url: imageURL) { [weak self] image in
            self?.castImageView.image = image
        }
    }

    // MARK: - Private methods

    private func setupUI() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        createCastImageView()
        createCastLabel()
    }

    private func createCastImageView() {
        castImageView.translatesAutoresizingMaskIntoConstraints = false
        castImageView.contentMode = .scaleAspectFill
        castImageView.clipsToBounds = true
        contentView.addSubview(castImageView)
        setupCastImageViewAnchor()
    }

    private func createCastLabel() {
        castLabel.translatesAutoresizingMaskIntoConstraints = false
        castLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        castLabel.textAlignment = .center
        castLabel.numberOfLines = 2
        contentView.addSubview(castLabel)
        setupCastLabelAnchor()
    }

    private func setupCastImageViewAnchor() {
        NSLayoutConstraint.activate([
            castImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            castImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            castImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            castImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }

    private func setupCastLabelAnchor() {
        NSLayoutConstraint.activate([
            castLabel.topAnchor.constraint(equalTo: castImageView.bottomAnchor),
            castLabel.rightAnchor.constraint(equalTo: rightAnchor),
            castLabel.leftAnchor.constraint(equalTo: leftAnchor),
            castLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
