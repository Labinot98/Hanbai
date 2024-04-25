//
//  ComicsViewModel.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import SwiftUI

class ComicsViewModel: ObservableObject {
    @Published var comics: [Comic] = []
    @Published var isLoading: Bool = false
    
    private let comicUseCase: ComicUseCase
    
    init(comicUseCase: ComicUseCase) {
        self.comicUseCase = comicUseCase
    }
    
    func fetchComics() {
        isLoading = true
        comicUseCase.fetchComics { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let comics):
                    self?.comics = comics
                case .failure(let error):
                    print("Error fetching comics: \(error)")
                }
            }
        }
    }
}

