// MovieListViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран выбора фильмов
final class MovieListViewController: UIViewController {
    private enum Constants {
        static let listCellIdentifire = "listCell"
        static let url =
            "https://api.themoviedb.org/3/movie/popular?api_key=301bf8bb0ae60538292cdebf5a3021dd&language=ru-RU"
    }

    // MARK: - Private Properties

    private let tableView = UITableView()
    private lazy var header: UIView = {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50)
        headerView.backgroundColor = .gray
        return headerView
    }()

    private let segmentControll: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        segmentControl.backgroundColor = .blue
        segmentControl.frame = CGRect(x: 0, y: 0, width: 390, height: 20)
        return segmentControl
    }()

    private var movies: [Movies]?

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        fetchData()
        createTableView()
    }

    private func fetchData() {
        NetworkManager.fetchData(url: Constants.url) { movies in
            self.movies = movies.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func createTableView() {
        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieListViewCell.self, forCellReuseIdentifier: Constants.listCellIdentifire)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
//        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        header.addSubview(segmentControll)
        tableView.tableHeaderView = header
        view.addSubview(tableView)
        createTableViewAnchor()
    }

    private func createSegmentControl() {
        segmentControll.frame = CGRect(x: 0, y: 0, width: 390, height: 20)
        segmentControll.backgroundColor = .blue
    }

    private func createTableViewAnchor() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
        cell.backgroundColor = .cyan
        cell.movies(myMovie)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let descriptionVS = DescriptionViewController()
        navigationController?.pushViewController(descriptionVS, animated: true)
    }
}
