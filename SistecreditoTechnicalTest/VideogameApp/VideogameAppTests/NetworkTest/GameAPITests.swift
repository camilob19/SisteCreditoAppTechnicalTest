//
//  GameAPITests.swift
//  VideogameAppTests
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import XCTest
import Dependencies
import Alamofire
@testable import VideogameApp

final class GameAPITests: XCTestCase {

    func test_load_games_success() async throws {
        let SUT = withDependencies {
            let client = FakeHTTPClient()
            client.file = "games"
            client.expectedURL = "https://www.freetogame.com/api/games"
            $0.httpClient = client
        } operation: {
            GamesAPIImpl()
        }

        let result = await SUT.getGames()
        switch result {
        case let .success(games):
            XCTAssertEqual(games.count, 376)
        case .failure:
            XCTFail("Error")
        }
    }
    
    func test_load_game_success() async throws {
        let SUT = withDependencies {
            let client = FakeHTTPClient()
            client.file = "game"
            client.expectedURL = "https://www.freetogame.com/api/game?id=1"
            $0.httpClient = client
        } operation: {
            GamesAPIImpl()
        }

        let result = await SUT.getGame(id: 1)
        switch result {
        case let .success(game):
            XCTAssertEqual(game.title, "Call Of Duty: Warzone")
        case .failure:
            XCTFail("Error")
        }
        
    }
}

final class FakeHTTPClient: HTTPClientProtocol {
    var file: String = ""
    var expectedURL: String = ""
    func request<T>(url: Alamofire.URLRequestConvertible) async -> Result<T, VideogameApp.NetworkError> where T : Decodable {
        guard let fullURL = url.urlRequest?.description,
              fullURL.contains(expectedURL) else {
            return .failure(NetworkError.decodableError)
        }
        
        guard let responseJson = self.loadJson(filename: file, T: T.self) else {
            return .failure(NetworkError.decodableError)
        }
        
        return .success(responseJson)
    }
    
    func loadJson<T:Decodable>(filename fileName: String, T: T.Type) -> T? {
        if let url = Bundle(for: FakeHTTPClient.self).url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("Error")
            }
        }
        return nil
    }
}
