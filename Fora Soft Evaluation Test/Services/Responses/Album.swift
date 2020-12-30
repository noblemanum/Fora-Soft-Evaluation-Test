//
//  Album.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import Foundation

struct Album: Decodable {
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case collectionId
        case artistName
        case collectionName
        case artworkUrl = "artworkUrl100"
    }
}
