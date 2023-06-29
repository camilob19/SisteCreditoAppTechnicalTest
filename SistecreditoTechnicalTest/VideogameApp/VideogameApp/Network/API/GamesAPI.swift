//
//  GamesAPI.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import Foundation
import Dependencies

protocol GamesAPI {
    func getGames() async -> Swift.Result<[Game], NetworkError>
    func getGame(id: Int) async -> Swift.Result<Game, NetworkError>
}

final class GamesAPIImpl: GamesAPI {
    @Dependency(\.httpClient)var httpClient
    
    func getGames() async -> Swift.Result<[Game], NetworkError> {
        await httpClient.request(url: GamesRouter.getGames)
    }
    
    func getGame(id: Int) async -> Swift.Result<Game, NetworkError> {
        await httpClient.request(url: GamesRouter.getGame(id: id))
    }
}
