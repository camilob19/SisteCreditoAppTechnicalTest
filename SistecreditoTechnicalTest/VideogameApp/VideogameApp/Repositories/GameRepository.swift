//
//  GameRepository.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import Foundation
import Dependencies

protocol GameRepository {
    func getGames() async -> Swift.Result<[Game], NetworkError>
    func getGame(id: Int) async -> Swift.Result<Game, NetworkError>
    @discardableResult
    func addToFavorites(_ game: Game) -> Bool
    func getFavorites() -> [Game]
}

final class GameRepositoryImpl: GameRepository {
    @Dependency(\.gamePersistence) private var gamePersistence
    @Dependency(\.gameAPI) private var gameAPI
    
    func getGames() async -> Swift.Result<[Game], NetworkError> {
        await gameAPI.getGames()
    }
    
    func getGame(id: Int) async -> Swift.Result<Game, NetworkError> {
        await gameAPI.getGame(id: id)
    }
    
    func addToFavorites(_ game: Game) -> Bool {
        gamePersistence.saveGame(game: game)
        return true
    }
    
    func getFavorites() -> [Game] {
        gamePersistence.getGames()
    }
}
