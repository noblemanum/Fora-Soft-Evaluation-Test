//
//  URL+ForaSoft.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 28.12.2020.
//

import Foundation

extension URL {
    
    func withQueries(_ query: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = query.map { URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
    }
}
