// DescriptionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран описания фильмов
final class DescriptionViewController: UIViewController {
    private enum Constants {
        static let cellIdentifire = "descriptionCell"
    }

    private enum CellType {
        case descriptionCell
    }

    // MARK: - Private Visual Components

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()

    // MARK: - Public Properties

    var urlString = ""

    // MARK: - Private Properties

    private let cellTypes: [CellType] = [.descriptionCell]
    private var movie: Movies?

    // MARK: - Life Cyecles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        configurateView()
        createTableView()
        createRefreshControl()
        fetchData()
    }

    private func configurateView() {
        view.backgroundColor = .systemBackground
    }

    private func fetchData() {
        NetworkManager.fetchGenericData(url: urlString) { [weak self] (movies: Movies) in
            self?.movie = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func createRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshedAction), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    private func createTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DescriptionViewCell.self, forCellReuseIdentifier: Constants.cellIdentifire)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        view.addSubview(tableView)
        createTableViewAnchor()
    }

    private func createTableViewAnchor() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    @objc private func refreshedAction() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension DescriptionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.cellIdentifire,
                for: indexPath
            ) as? DescriptionViewCell
        else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.sendMovie(movie)
        return cell
    }
}

extension DescriptionViewController: PresentViewControllerDelegate {
    func goToVC(param: UIViewController) {
        present(param, animated: true)
    }
}
