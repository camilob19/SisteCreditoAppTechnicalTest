//
//  VideogameAppApp.swift
//  VideogameApp
//
//  Created by Cristian on 27/06/23.
//

import SwiftUI

@main
struct VideogameAppApp: App {
    var body: some Scene {
        WindowGroup {
            /// Validate that the execution is not from unit test
            if NSClassFromString("XCTest") == nil {
                SplashView()
            }
        }
    }
}

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
