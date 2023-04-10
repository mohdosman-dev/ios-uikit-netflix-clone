//
//  TrendingModel.swift
//  NetflixClone
//
//  Created by Mohammed Osman on 10/04/2023.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let trendingModel = try? JSONDecoder().decode(TrendingModel.self, from: jsonData)

// MARK: - TrendingMovieResponse
struct TrendingMovieResponse: Codable {
    let results: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title, originalTitle: String?
    let originalLanguage, overview: String
    let posterPath, mediaType: String
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
