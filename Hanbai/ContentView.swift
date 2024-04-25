//
//  ContentView.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 24.4.24..
//

import SwiftUI

struct ComicsView: View {
    @StateObject private var viewModel = ComicsViewModel(comicUseCase: ComicInteractor(comicRepository: MarvelComicRepository(apiManager: MarvelAPIManager())))
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    List(viewModel.comics, id: \.id) { comic in
                        Text(comic.title)
                    }
                    .padding()
                }
            }
            .onAppear {
                viewModel.fetchComics()
            }
            .navigationTitle("Marvel Comics")
        }
    }
}



//struct ComicDetailView: View {
//    let comic: Comic
//
//    var body: some View {
//        VStack {
//            Text(comic.title)
//                .font(.title)
//            Text("Creators:")
//                .font(.headline)
//            ForEach(comic.creators, id: \.name) { creator in
//                Text(creator.name)
//                    .font(.subheadline)
//            }
//            Spacer()
//        }
//        .padding()
//    }
//}
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

// Domain Layer

import Foundation

protocol ComicUseCase {
    func fetchComics(completion: @escaping (Result<[Comic], AppError>) -> Void)
}

class ComicInteractor: ComicUseCase {
    private let comicRepository: ComicRepository
    
    init(comicRepository: ComicRepository) {
        self.comicRepository = comicRepository
    }
    
    func fetchComics(completion: @escaping (Result<[Comic], AppError>) -> Void) {
        comicRepository.fetchComics(completion: completion)
    }
}

// Presentation Layer

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
                    // Handle error
                }
            }
        }
    }
}
