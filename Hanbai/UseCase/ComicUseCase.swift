//
//  ComicUseCase.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import Foundation

protocol ComicUseCase {
    func fetchComics(completion: @escaping (Result<[Comic], AppError>) -> Void)
}
