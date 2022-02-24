//
//  Podcast.swift
//  Podcast

import Foundation

struct PodcastWrapper: Decodable {
    let results: [Podcast]
}

struct Podcast: Decodable {
    let collectionName: String
    let artworkUrl100: String
    let artworkUrl600: String
    let artistName: String
}
