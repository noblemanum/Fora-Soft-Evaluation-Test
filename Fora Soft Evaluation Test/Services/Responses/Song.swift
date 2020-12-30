//
//  Song.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import Foundation

struct Song: Decodable {
    let trackName: String
    let trackNumber: Int
    let discNumber: Int
    let trackTimeMillis: Int
}
