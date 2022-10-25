// NetworkManeger.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Получение данных по API - основной
class NetworkManager {
    static func downLoadImage(url: String, comlition: @escaping (_ image: UIImage) -> ()) {
        guard let url = URL(string: url) else { return }

        let session = URLSession.shared
        session.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    comlition(image)
                }
            }
        }.resume()
    }

    static func fetchData(url: String, comlition: @escaping (_ movies: MoviesResult) -> ()) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            print(data)

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let moviesDiscription = try decoder.decode(MoviesResult.self, from: data)
                print(moviesDiscription)
                comlition(moviesDiscription)
            } catch {
                print("error since", error)
            }
        }.resume()
    }
}
