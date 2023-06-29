//
//  UseCase.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Foundation
import Dependencies

protocol GetGamesUseCase {
    func execute() async -> Swift.Result<[Game], NetworkError>
}

final class GetGamesUseCaseImpl: GetGamesUseCase {
    
    @Dependency(\.gameRepository) var gameRepository
    
    func execute() async -> Swift.Result<[Game], NetworkError> {
        return await gameRepository.getGames()
    }
}
