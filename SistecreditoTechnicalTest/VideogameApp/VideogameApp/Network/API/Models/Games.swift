//
//  Games.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import Foundation

struct GameScreenshot: Equatable, Identifiable, Hashable, Decodable {
    let id: Int
    let image: String
}

struct Game: Equatable, Identifiable, Hashable, Decodable {
    let id: Int
    let title: String
    let thumbnail: String
    let shortDescription: String
    let gameUrl: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let freetogameProfileUrl: String
    
    let status: String?
    let description: String?
    let screenshots: [GameScreenshot]?
}

extension Game {
    static let fixture: Self = Game(
        id: 1234,
        title: "Overwatch 2",
        thumbnail: "https://www.freetogame.com/g/540/thumbnail.jpg",
        shortDescription: "A hero-focused first-person team shooter from Blizzard Entertainment.",
        gameUrl: "https://www.freetogame.com/open/overwatch-2",
        genre: "Shooter",
        platform: "PC (Windows)",
        publisher: "Activision Blizzard",
        developer: "Blizzard Entertainment",
        releaseDate: "2022-10-04",
        freetogameProfileUrl: "https://www.freetogame.com/overwatch-2",
        status: "Live",
        description: "Description",
        screenshots: []
    )
    
    static let fixtureList: [Self] = [Game.fixture]
}
