//
//  MarvelComicRepository.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import Foundation

protocol ComicRepository {
    func fetchComics(completion: @escaping (Result<[Comic], AppError>) -> Void)
}

class MarvelComicRepository: ComicRepository {
    private let apiManager: MarvelAPIManager
    
    init(apiManager: MarvelAPIManager) {
        self.apiManager = apiManager
    }
    
    func fetchComics(completion: @escaping (Result<[Comic], AppError>) -> Void) {
        apiManager.fetchComics(completion: completion)
    }
}
