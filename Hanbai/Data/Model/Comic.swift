//
//  ComicModel.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import Foundation

struct Comic: Codable {
    let id: Int
    let title: String
    let creators: ComicCreators
}

struct Response: Codable {
    let data: ComicData
}

struct ComicData: Codable {
    let results: [Comic]
}

struct ComicCreators: Codable {
    let items: [Creator]
}

struct Creator: Codable {
    let name: String
    let role: String
}
