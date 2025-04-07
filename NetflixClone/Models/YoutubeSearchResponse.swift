//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by Mohammed Osman on 11/04/2023.
//

import Foundation


// MARK: - YoutubeSearchResponse
struct YoutubeSearchResponse: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: VideoElement
}

// MARK: - ID
struct VideoElement: Codable {
    let kind, videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}
