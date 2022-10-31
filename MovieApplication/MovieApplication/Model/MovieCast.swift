// MovieCast.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Актеры кино
struct MovieCast: Decodable {
    var cast: [Cast]?
}

/// Информация об актере
struct Cast: Decodable {
    var profilePath: String?
    var originalName: String?
}
