//
//  ComicsViewModel.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import SwiftUI

class ComicsViewModel: ObservableObject {
    
    @Published var groupedComics: [String: [Comic]] = [:]
    @Published var isLoading: Bool = false
    
    private let comicUseCase: ComicUseCase
    var sortedGroupedComics: [(String, [Comic])] {
           return groupedComics.sorted(by: { $0.key < $1.key })
       }
    
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
                    self?.groupedComics = self?.groupComicsByCreators(comics) ?? [:]
                case .failure(let error):
                    print("Error fetching comics: \(error)")
                }
            }
        }
    }
    
   private func groupComicsByCreators(_ comics: [Comic]) -> [String: [Comic]] {
           var groupedComics: [String: [Comic]] = [:]
           for comic in comics {
               for creator in comic.creators.items {
                   if var comicsForCreator = groupedComics[creator.name] {
                       comicsForCreator.append(comic)
                       groupedComics[creator.name] = comicsForCreator
                   } else {
                       groupedComics[creator.name] = [comic]
                   }
               }
           }
           return groupedComics
       }
}

