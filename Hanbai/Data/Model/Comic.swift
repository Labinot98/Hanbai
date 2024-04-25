//
//  ComicModel.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import Foundation

struct Comic: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail?
}

struct Response: Codable {
    let data: ComicData
}

struct ComicData: Codable {
    let results: [Comic]
}
