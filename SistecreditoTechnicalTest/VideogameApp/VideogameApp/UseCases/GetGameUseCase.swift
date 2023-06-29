//
//  GetGameUseCase.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Foundation
import Dependencies

protocol GetGameUseCase {
    func execute(id: Int) async -> Swift.Result<Game, NetworkError>
}

final class GetGameUseCaseImpl: GetGameUseCase {
    
    @Dependency(\.gameRepository) var gameRepository
    
    func execute(id: Int) async -> Swift.Result<Game, NetworkError> {
        return await gameRepository.getGame(id: id)
    }
}
