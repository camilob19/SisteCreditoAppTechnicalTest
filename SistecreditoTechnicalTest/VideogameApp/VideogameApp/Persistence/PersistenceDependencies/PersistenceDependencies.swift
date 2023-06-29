//
//  PersistenceDependencies.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import Foundation
import Dependencies

private enum PersistenceKey: DependencyKey {
    static let liveValue: GamePersistence = GamePersistenceImpl()
}

private enum RealmManagerKey: DependencyKey {
    static let liveValue: PersistenceManager = PersistenceManagerImpl()
    static let testValue: PersistenceManager = PersistenceManagerImpl()
}

extension DependencyValues {
    var gamePersistence: GamePersistence {
        get { self[PersistenceKey.self] }
        set { self[PersistenceKey.self] = newValue }
    }
    
    var realmManager: PersistenceManager {
        get { self[RealmManagerKey.self] }
        set { self[RealmManagerKey.self] = newValue }
    }
}
