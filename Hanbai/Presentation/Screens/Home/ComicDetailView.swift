//
//  ComicDetailView.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import SwiftUI

struct ComicDetailView: View {
    let comic: Comic

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(comic.title)
                    .font(.title2)
                    .fontWeight(.bold)
                Divider()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Creators:")
                        .font(.headline)
                    Divider()
                    ForEach(comic.creators.items, id: \.name) { creator in
                        HStack(alignment: .center) {
                            Text(creator.name)
                                .font(.subheadline)
                            Text(creator.role)
                        }
                        Divider()
                    }
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Comic Detail")
    }
}
