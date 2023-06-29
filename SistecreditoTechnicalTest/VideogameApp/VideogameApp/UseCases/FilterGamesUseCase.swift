//
//  FilterGamesUseCase.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Foundation
import Dependencies

protocol FilterGamesUseCase {
    func execute(games: [Game], filterBy: [GameFilters]) -> [Game]
}

enum GameFilters {
    case date
    case name(String)
}

final class FilterGamesUseCaseImpl: FilterGamesUseCase {
    
    @Dependency(\.gameRepository) var gameRepository
    
    func execute(games: [Game], filterBy: [GameFilters]) -> [Game] {
        var filteredGames: [Game] = games
        filterBy.forEach { filter in
            switch filter {
            case let .name(text):
                filteredGames = filterByName(text, games: filteredGames)
            case .date:
                filteredGames = orderByDate(games: filteredGames)
            }
        }
        return filteredGames
    }
    
    private func orderByDate(games: [Game]) -> [Game] {
        let gamesFilteres = games.compactMap { game in
            if game.releaseDate.date(using: .serverFormat) != nil {
                return game
            }
            return nil
        }
        return gamesFilteres.sorted { $0.releaseDate.date(using: .serverFormat) ?? Date() > $1.releaseDate.date(using: .serverFormat) ?? Date() }
    }
    
    private func filterByName(_ text: String, games: [Game]) -> [Game] {
        guard !text.isEmpty else { return games }
        return games.filter { $0.title.localizedCaseInsensitiveContains(text) }
    }
}
