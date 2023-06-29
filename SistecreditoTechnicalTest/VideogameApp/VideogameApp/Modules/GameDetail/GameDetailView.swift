//
//  GameDetail.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import SwiftUI
import CachedAsyncImage

struct GameDetailView: View {
    
    @ObservedObject var viewModel: GameDetailViewModel
    var body: some View {
        VStack {
            CachedAsyncImage(url: URL(string: viewModel.game.thumbnail)) { img in
                img
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            
            ScrollView {
                Text(viewModel.game.title)
                Text(viewModel.game.description ?? "")
            }
            
            Button {
                viewModel.addToFavorites()
            } label: {
                Text("title_add_favorites".localized())
            }
        }
        .onAppear {
            viewModel.loadGame()
        }
        .navigationTitle(viewModel.game.title)
        .padding()
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(viewModel: GameDetailViewModel(game: Game.fixture))
    }
}
