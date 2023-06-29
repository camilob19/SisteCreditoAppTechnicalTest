//
//  UseCaseDependencies.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 28/06/23.
//

import Foundation
import Dependencies

private enum GetGamesUseCaseKey: DependencyKey {
    static let liveValue: GetGamesUseCase = GetGamesUseCaseImpl()
}

private enum SaveFavoritesUseCaseKey: DependencyKey {
    static let liveValue: SaveFavoritesUseCase = SaveFavoritesUseCaseImpl()
}

private enum GetGameUseCaseKey: DependencyKey {
    static let liveValue: GetGameUseCase = GetGameUseCaseImpl()
}

private enum GetFavoritesUseCaseKey: DependencyKey {
    static let liveValue: GetFavoritesUseCase = GetFavoritesUseCaseImpl()
}

private enum FilterGamesUseCaseKey: DependencyKey {
    static let liveValue: FilterGamesUseCase = FilterGamesUseCaseImpl()
}

extension DependencyValues {
    var saveFavoritesUseCase: SaveFavoritesUseCase {
        get { self[SaveFavoritesUseCaseKey.self] }
        set { self[SaveFavoritesUseCaseKey.self] = newValue }
    }
    
    var getGamesUseCase: GetGamesUseCase {
        get { self[GetGamesUseCaseKey.self] }
        set { self[GetGamesUseCaseKey.self] = newValue }
    }
    
    var getGameUseCase: GetGameUseCase {
        get { self[GetGameUseCaseKey.self] }
        set { self[GetGameUseCaseKey.self] = newValue }
    }
    
    var getFavoritesUseCase: GetFavoritesUseCase {
        get { self[GetFavoritesUseCaseKey.self] }
        set { self[GetFavoritesUseCaseKey.self] = newValue }
    }
    
    var filterGamesUseCase: FilterGamesUseCase {
        get { self[FilterGamesUseCaseKey.self] }
        set { self[FilterGamesUseCaseKey.self] = newValue }
    }
}
