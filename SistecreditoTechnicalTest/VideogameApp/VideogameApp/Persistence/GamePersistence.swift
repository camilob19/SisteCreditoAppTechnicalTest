//
//  GamePersistence.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import Foundation
import RealmSwift
import Dependencies

final class RealmGame: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var gameId: Int
    @Persisted var title: String
    @Persisted var thumbnail: String
    @Persisted var shortDescription: String
    @Persisted var gameUrl: String
    @Persisted var genre: String
    @Persisted var platform: String
    @Persisted var publisher: String
    @Persisted var developer: String
    @Persisted var releaseDate: String
    @Persisted var freetogameProfileUrl: String
}

protocol GamePersistence {
    func getGames() -> [Game]
    func saveGame(game: Game)
}

final class GamePersistenceImpl: GamePersistence {
    @Dependency(\.realmManager) var realmManager
    
    func saveGame(game: Game) {
        let realGame = RealmGame()
        realGame._id = "\(game.id)"
        realGame.gameId = game.id
        realGame.title = game.title
        realGame.thumbnail = game.thumbnail
        realGame.shortDescription = game.shortDescription
        realGame.gameUrl = game.gameUrl
        realGame.genre = game.genre
        realGame.platform = game.platform
        realGame.publisher = game.publisher
        realGame.developer = game.developer
        realGame.releaseDate = game.releaseDate
        realmManager.saveObject(realGame, update: false)
    }
    
    func getGames() -> [Game] {
        guard let games = realmManager.fetchObjects(RealmGame.self) else {
            return []
        }
        
        return games.map {
            return Game(
                id: $0.gameId,
                title: $0.title,
                thumbnail: $0.thumbnail,
                shortDescription: $0.shortDescription,
                gameUrl: $0.gameUrl,
                genre: $0.genre,
                platform: $0.platform,
                publisher: $0.publisher,
                developer: $0.developer,
                releaseDate: $0.releaseDate,
                freetogameProfileUrl: $0.freetogameProfileUrl,
                status: "",
                description: "",
                screenshots: []
            )
        }
    }
}
