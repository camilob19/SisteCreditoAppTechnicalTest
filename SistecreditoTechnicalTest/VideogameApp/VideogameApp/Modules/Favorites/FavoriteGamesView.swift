//
//  FavoriteGames.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import SwiftUI

struct FavoriteGamesView: View {
    
    @ObservedObject var viewModel = FavoritesViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    viewModel.orderByDate()
                } label: {
                    if !viewModel.isOrderedByDate {
                        Text("sort_filter_text".localized())
                    } else {
                        Text("restore_filter_text".localized())
                    }
                }
                List(viewModel.filteredGames, id: \.self) { game in
                    GameRowView(game: game)
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText)
                .navigationTitle("title_favorite".localized())
                .navigationDestination(for: Game.self) { game in
                    GameDetailView(viewModel: GameDetailViewModel(game: game))
                }
            }
        }
        .onAppear {
            viewModel.loadGames()
        }
    }
}

struct FavoriteGamesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteGamesView()
    }
}
