//
//  GetFavoritesUseCase.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Foundation
import Dependencies

protocol GetFavoritesUseCase {
    func execute() -> [Game]
}

final class GetFavoritesUseCaseImpl: GetFavoritesUseCase {
    
    @Dependency(\.gameRepository) var gameRepository
    
    func execute() -> [Game] {
        gameRepository.getFavorites()
    }
}
