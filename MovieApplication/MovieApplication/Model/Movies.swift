// Movies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
/// Модель для принятия информации из сервера
struct MoviesResult: Decodable {
    let results: [Movies]
}

/// Детали фильма
struct Movies: Decodable {
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Float
    let revenue: Int?
    let runtime: Int?
    let backdropPath: String
    let imdbId: String?
    let budget: Int?
    let genres: [Genres]?
    let tagline: String?
    let reliseData: String?
}

// Жанры
struct Genres: Decodable {
    let id: Int?
    let name: String?
}
