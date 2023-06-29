//
//  RepositoryDependencies.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Foundation
import Dependencies

private enum GameRepositoryKey: DependencyKey {
    static let liveValue: GameRepository = GameRepositoryImpl()
}

extension DependencyValues {
    var gameRepository: GameRepository {
        get { self[GameRepositoryKey.self] }
        set { self[GameRepositoryKey.self] = newValue }
    }
}
