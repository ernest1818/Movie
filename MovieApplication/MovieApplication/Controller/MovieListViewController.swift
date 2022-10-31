// MovieListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран выбора фильмов
final class MovieListViewController: UIViewController {
    private enum Constants {
        static let titleText = "Movie"
        static let listCellIdentifire = "listCell"
        static let popularUrl =
            "https://api.themoviedb.org/3/movie/popular?api_key=301bf8bb0ae60538292cdebf5a3021dd&language=ru-RU"
        static let upCommingUrl =
            "https://api.themoviedb.org/3/movie/upcoming?api_key=301bf8bb0ae60538292cdebf5a3021dd&language=ru-RU"
        static let topUrl =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=301bf8bb0ae60538292cdebf5a3021dd&language=ru-RU"
        static let movieLink = "https://api.themoviedb.org/3/movie/"
        static let apiKeyLink = "?api_key=301bf8bb0ae60538292cdebf5a3021dd"
        static let languageLink = "&language=ru-RU"
        static let popularSegmantName = "Popular"
        static let topSegmentName = "Top"
        static let newSegmentName = "New"
    }

    // MARK: - Private Visual Components

    private let tableView = UITableView()
    private lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    private let segmentControl: UISegmentedControl = {
        let segmentControl =
            UISegmentedControl(items: [
                Constants.popularSegmantName,
                Constants.topSegmentName,
                Constants.newSegmentName
            ])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        segmentControl.selectedSegmentTintColor = .systemYellow
        return segmentControl
    }()

    // MARK: - Private Properties

    private var movies: [Movies]?
    private var urlString = Constants.popularUrl

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        createSegmentControl()
        fetchData()
        createTableView()
        createViewConfiguration()
    }

    private func fetchData() {
        NetworkManager.fetchGenericData(url: urlString, comlition: { [weak self] (movies: MoviesResult) in
            self?.movies = movies.results
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }

    private func createViewConfiguration() {
        view.backgroundColor = .systemBackground
        title = Constants.titleText
        navigationController?.navigationBar.tintColor = .systemOrange
    }

    private func createTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieListViewCell.self, forCellReuseIdentifier: Constants.listCellIdentifire)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        createTableViewAnchor()
    }

    private func createSegmentControl() {
        segmentControl.backgroundColor = .systemOrange
        segmentControl.addTarget(self, action: #selector(segmentControlAction), for: .valueChanged)
        view.addSubview(headerView)
        headerView.addSubview(segmentControl)
        createSegmentConrolAnchor()
        createHeaderAncgor()
    }

    private func createSegmentConrolAnchor() {
        segmentControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1).isActive = true
    }

    private func createHeaderAncgor() {
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    }

    private func createTableViewAnchor() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func getToDiscriptionVC(path: IndexPath) {
        let descriptionVS = DescriptionViewController()
        guard let id = movies?[path.row].id else { return }
        descriptionVS
            .urlString = "\(Constants.movieLink)\(id)\(Constants.apiKeyLink)\(Constants.languageLink)"
        navigationController?.pushViewController(descriptionVS, animated: true)
    }

    @objc private func segmentControlAction() {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            NetworkManager.fetchGenericData(url: Constants.popularUrl) { [weak self] (movies: MoviesResult) in
                self?.movies = movies.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    let indexPath = IndexPath(row: 0, section: 0)
                    self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        case 1:
            NetworkManager.fetchGenericData(url: Constants.topUrl) { [weak self] (movies: MoviesResult) in
                self?.movies = movies.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    let indexPath = IndexPath(row: 0, section: 0)
                    self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        case 2:
            NetworkManager.fetchGenericData(url: Constants.upCommingUrl) { [weak self] (movies: MoviesResult) in
                self?.movies = movies.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    let indexPath = IndexPath(row: 0, section: 0)
                    self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        default:
            break
        }
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = movies?.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.listCellIdentifire,
            for: indexPath
        ) as? MovieListViewCell,
            let myMovie = movies?[indexPath.row]
        else { return UITableViewCell() }
        cell.movies(myMovie)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getToDiscriptionVC(path: indexPath)
    }
}
