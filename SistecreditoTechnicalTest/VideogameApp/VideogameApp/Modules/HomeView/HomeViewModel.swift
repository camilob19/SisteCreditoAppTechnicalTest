//
//  HomeViewModel.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Dependencies
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var games: [Game] = []
    @Published var filteredGames: [Game] = []
    @Published var isOrderedByDate: Bool = false
    @Published var searchText: String = "" {
        didSet {
            filterGames(by: searchText)
        }
    }
    
    @Dependency(\.getGamesUseCase) var getGamesUseCase
    @Dependency(\.filterGamesUseCase) var filterGamesUseCase
    
    /// Load all the games out of MainActor context avoinding MainThread overloading
    func loadGames() {
        /// .utility is recommended by apple for service requests
        Task.detached(priority: .utility) {
            let result = await self.getGamesUseCase.execute()
            switch result {
            case let .success(games):
                /// comming back to MainActor context once we have the results from the service
                await MainActor.run {
                    self.games = games
                    self.filteredGames = games
                }
            default: break
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
