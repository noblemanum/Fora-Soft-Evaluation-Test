//
//  Safe.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import Foundation

struct Safe<T: Decodable>: Decodable {
    
    let value: T?
    
    init(from decoder: Swift.Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try? container.decode(T.self)
    }
}
