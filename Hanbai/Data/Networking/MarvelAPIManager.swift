//
//  MarvelAPIManager.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import Foundation

enum AppError: Error {
    case networkError(String)
    case parsingError(String)
}


struct MarvelAPIManager {
    
    static let publicKey = "549327aceb8702908ecd42306da09274"
    static let privateKey = "19300152f5f9afe5785f9795d7baf9de57ea8dff"
    static let baseURL = "https://gateway.marvel.com/v1/public/comics"

    func fetchComics(completion: @escaping (Result<[Comic], AppError>) -> Void) {
        guard var urlComponents = URLComponents(string: MarvelAPIManager.baseURL) else {
            completion(.failure(.networkError("Invalid URL")))
            return
        }
        
        let timestamp = Date().timeIntervalSince1970
        let hash = "\(timestamp)\(MarvelAPIManager.privateKey)\(MarvelAPIManager.publicKey)".md5Hash

        let queryItems = [
            URLQueryItem(name: "apikey", value: MarvelAPIManager.publicKey),
            URLQueryItem(name: "ts", value: "\(timestamp)"),
            URLQueryItem(name: "hash", value: hash)
        ]
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.networkError("Invalid URL")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            
            guard let data = data else {
                completion(.failure(.networkError("No data received")))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(Response.self, from: data)
                completion(.success(response.data.results))
            } catch {
                completion(.failure(.parsingError(error.localizedDescription)))
            }
            
        }.resume()
    }
}
