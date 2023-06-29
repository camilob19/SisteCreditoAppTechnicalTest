//
//  GameListView.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import SwiftUI
import CachedAsyncImage

struct GameRowView: View {
    var game: Game
    
    var body: some View {
        ZStack {
            NavigationLink(value: game) { EmptyView() }.opacity(0.0)
            ZStack {
                CachedAsyncImage(url: URL(string: game.thumbnail)) { img in
                    img
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                VStack {
                    Spacer()
                    VStack {
                        Text(game.title)
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold, design: .default))
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .opacity(0.7)
                }
            }
        }
        .listRowInsets(EdgeInsets())
    }
}

@MainActor
struct GameListView: View {
    @ObservedObject var viewModel = HomeViewModel()
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
                .navigationTitle("title_game_list".localized())
                .searchable(text: $viewModel.searchText)
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

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
