//
//  SongsProvider.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import Foundation

class SongsProvider {
    
    private init() {}
    
    static let shared = SongsProvider()
    
    func getSongs(forAlbum id: Int, completion: @escaping(Result<[Song], Error>) -> Void) {
        let baseURL = URL(string: "https://itunes.apple.com/lookup")!
        
        let query = [
            "id": String(id),
            "entity": "song",
        ]
        
        guard let url = baseURL.withQueries(query) else {
            completion(.failure(ProviderError.badRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
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
            
            if let songs: ResultsResponse<Song> = Decoder.decode(data: data) {
                DispatchQueue.main.async {
                    completion(.success(songs.results))
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
