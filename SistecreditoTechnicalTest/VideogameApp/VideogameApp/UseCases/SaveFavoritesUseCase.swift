//
//  SaveFavoritesUseCase.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Foundation
import Dependencies

protocol SaveFavoritesUseCase {
    func execute(game: Game)
}

final class SaveFavoritesUseCaseImpl: SaveFavoritesUseCase {
    
    @Dependency(\.gameRepository) var gameRepository
    
    func execute(game: Game) {
        gameRepository.addToFavorites(game)
    }
}
