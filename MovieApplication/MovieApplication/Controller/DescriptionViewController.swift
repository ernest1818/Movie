// DescriptionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран описания фильмов
class DescriptionViewController: UIViewController {
    // MARK: - Private Properties

    private let descriptionImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let avarageLabel = UILabel()

    // MARK: - Life Cyecles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        createUIDescription()
        createImageView()
        createDescriptionLabel()
    }

    private func createUIDescription() {}

    private func createDescriptionLabel() {
        descriptionLabel.backgroundColor = .orange
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        createDescriptionLabelAnchor()
    }

    private func createImageView() {
        descriptionImageView.backgroundColor = .orange
        descriptionImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionImageView)
        createImageViewAnchor()
    }

    private func createDescriptionLabelAnchor() {
        NSLayoutConstraint.activate(
            [
                descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                descriptionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
                descriptionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
            ]
        )
    }

    private func createImageViewAnchor() {
        descriptionImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10)
            .isActive = true
        descriptionImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)
            .isActive = true
        descriptionImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
            .isActive = true
    }
}
