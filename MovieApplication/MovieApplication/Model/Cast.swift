// Cast.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Актеры кино
struct Cast: Decodable {
    var cast: [DescriptionCast]?
}

/// Информация об актере
struct DescriptionCast: Decodable {
    var profilePath: String?
    var originalName: String?
}
