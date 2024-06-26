//
//  ComicsView.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
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
                    List {
                        ForEach(viewModel.sortedGroupedComics, id: \.0) { creator, comics in
                            Section(header: Text(creator)) {
                                ForEach(comics, id: \.id) { comic in
                                    NavigationLink(destination: ComicDetailView(comic: comic)) {
                                        Text(comic.title)
                                    }
                                }
                            }
                        }
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
