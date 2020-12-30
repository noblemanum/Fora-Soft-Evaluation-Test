//
//  AlbumsProvider.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 28.12.2020.
//

import Foundation

class AlbumsProvider {
    
    private init() {}
    
    static let shared = AlbumsProvider()
    
    func getAlbums(ofTerm: String, completion: @escaping(Result<[Album], Error>) -> Void) {
        let baseURL = URL(string: "https://itunes.apple.com/search")!
        
        let query = [
            "term": ofTerm,
            "entity": "album",
        ]
        
        guard let url = baseURL.withQueries(query) else {
            completion(.failure(ProviderError.badRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(ProviderError.otherError(error)))
                }
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    completion(.failure(ProviderError.statusCode(response.statusCode)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(ProviderError.noResponse))
                }
            }
            
            if let albums: ResultsResponse<Album> = Decoder.decode(data: data) {
                DispatchQueue.main.async {
                    completion(.success(albums.results.sorted { $0.collectionName < $1.collectionName }))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(ProviderError.zeroData))
                }
            }
        }
        
        task.resume()
    }
}
