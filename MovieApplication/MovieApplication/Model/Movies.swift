// Movies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
/// Модель для принятия информации из сервера
struct MoviesResult: Decodable {
    let results: [Movies]
}

///
struct Movies: Decodable {
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Float
}
