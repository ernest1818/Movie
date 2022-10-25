// NetworkManeger.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// класс
class NetworkManager {
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
