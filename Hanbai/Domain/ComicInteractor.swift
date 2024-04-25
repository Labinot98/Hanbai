//
//  ComicInteractor.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import Foundation

class ComicInteractor: ComicUseCase {
    private let comicRepository: ComicRepository
    
    init(comicRepository: ComicRepository) {
        self.comicRepository = comicRepository
    }
    
    func fetchComics(completion: @escaping (Result<[Comic], AppError>) -> Void) {
        comicRepository.fetchComics(completion: completion)
    }
}
