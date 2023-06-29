//
//  HTTPClient.swift
//  VideogameApp
//
//  Created by Cristian Camilo Betancourt  on 27/06/23.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case decodableError
    case networkError
}

protocol HTTPClientProtocol: AnyObject {
    
    /// This function will get a URL convertible and will perform a
    /// service call and will transform the reponse
    /// - Parameter url: URL convertible from Alamofire
    /// - Returns: Result whether the response was valid struct or not
    func request<T: Decodable>(url: URLRequestConvertible) async -> Swift.Result<T, NetworkError>
}

final class HTTPClient: HTTPClientProtocol {
    
    let configuration = URLSessionConfiguration.af.default
    let session: Alamofire.Session
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init() {
        configuration.allowsCellularAccess = true
        session = Alamofire.Session(configuration: configuration)
    }
    
    func request<T: Decodable>(url: URLRequestConvertible) async -> Swift.Result<T, NetworkError> {
        await withCheckedContinuation { continuation in
            self.session
                .request(url)
                .responseDecodable(of: T.self, decoder: self.decoder) { response in
                    switch response.result {
                    case .success(let res):
                        continuation.resume(returning: .success(res))
                    case .failure:
                        continuation.resume(returning: .failure(NetworkError.decodableError))
                    }
                }
        }
        
    }
}
