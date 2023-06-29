//
//  APIDependencies.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import Foundation
import Dependencies

private enum HTTPClientKey: DependencyKey {
    static let liveValue: HTTPClientProtocol = HTTPClient()
}

private enum GameAPIKey: DependencyKey {
    static let liveValue: GamesAPI = GamesAPIImpl()
}

extension DependencyValues {
    var httpClient: HTTPClientProtocol {
        get { self[HTTPClientKey.self] }
        set { self[HTTPClientKey.self] = newValue }
    }
    
    var gameAPI: GamesAPI {
        get { self[GameAPIKey.self] }
        set { self[GameAPIKey.self] = newValue }
    }
}
