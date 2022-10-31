// NetworkManeger.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Получение данных по API - основной
final class NetworkManager {
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

    static func fetchGenericData<T: Decodable>(
        url: String,
        comlition: @escaping (T) -> ()
    ) {
        guard let url = URL(string: url) else { return }
        let urlSession = URLSession(configuration: .ephemeral)

        urlSession.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let moviesDiscription = try decoder.decode(T.self, from: data)
                comlition(moviesDiscription)
            } catch {
                print("error since", error)
            }
        }.resume()
    }
}
