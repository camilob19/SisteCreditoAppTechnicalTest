//
//  FavoritesViewModel.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Foundation
import Dependencies

@MainActor
final class FavoritesViewModel: ObservableObject {
    
    @Published var games: [Game] = []
    @Published var filteredGames: [Game] = []
    @Published var isOrderedByDate: Bool = false
    @Published var searchText: String = "" {
        didSet {
            filterGames(by: searchText)
        }
    }
    
    @Dependency(\.getFavoritesUseCase) var getFavoritesUseCase
    @Dependency(\.filterGamesUseCase) var filterGamesUseCase
    
    /// Load all the games out of MainActor context avoinding MainThread overloading
    func loadGames() {
        /// .utility is recommended by apple for service requests
        Task.detached(priority: .utility) {
            let games = await self.getFavoritesUseCase.execute()
            await MainActor.run {
                self.games = games
                self.filteredGames = games
            }
        }
    }
    
    func filterGames(by text: String) {
        guard !text.isEmpty else {
            filteredGames = games
            return
        }
        filteredGames = filterGamesUseCase.execute(games: games, filterBy: [.name(text)])
    }
    
    func orderByDate() {
        if !isOrderedByDate {
            filteredGames = filterGamesUseCase.execute(games: filteredGames, filterBy: [.date])
            isOrderedByDate = true
        } else {
            searchText = ""
            filteredGames = games
            isOrderedByDate = false
        }
    }
}
