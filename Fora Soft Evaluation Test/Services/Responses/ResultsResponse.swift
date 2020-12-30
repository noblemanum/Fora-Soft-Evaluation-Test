//
//  ResultsResponse.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import Foundation

struct ResultsResponse<T: Decodable>: Decodable {
    
    var results: [T] {
        return safeResults.compactMap { $0.value }
    }
    
    private let safeResults: [Safe<T>]
    
    private enum CodingKeys: String, CodingKey {
        case safeResults = "results"
    }
}
