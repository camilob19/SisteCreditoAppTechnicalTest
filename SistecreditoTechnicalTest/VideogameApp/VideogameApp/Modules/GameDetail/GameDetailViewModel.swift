//
//  GameDetailViewModel.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Dependencies
import Foundation

@MainActor
final class GameDetailViewModel: ObservableObject {
    
    @Published var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    @Dependency(\.getGameUseCase) var getGameUseCase
    @Dependency(\.saveFavoritesUseCase) var saveFavoritesUseCase
    
    /// Load the game out of MainActor context avoinding MainThread overloading
    func loadGame() {
        /// .utility is recommended by apple for service requests
        Task.detached(priority: .utility) {
            let result = await self.getGameUseCase.execute(id: self.game.id)
            switch result {
            case let .success(game):
                /// comming back to MainActor context once we have the result from the service
                await MainActor.run {
                    self.game = game
                }
            default: break
            }
        }
    }
    
    func addToFavorites() {
        saveFavoritesUseCase.execute(game: game)
    }
}

