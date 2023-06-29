//
//  GamesRouter.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import Foundation
import Alamofire

enum GamesRouter: URLRequestConvertible {
    case getGames
    case getGame(id: Int)
    
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getGames:
            return "games"
        case .getGame:
            return "game"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .getGame(id):
            return ["id": id]
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIConstants.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        if let parameters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
