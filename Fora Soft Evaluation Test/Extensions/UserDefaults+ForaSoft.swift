//
//  UserDefaults+ForaSoft.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import Foundation

enum DefaultsKey: String {
    case searchHistory
}

extension UserDefaults {
    
    func value<T>(for key: DefaultsKey) -> T? {
        return object(forKey: key.rawValue) as? T
    }
    
    func set(_ value: Any?, for key: DefaultsKey) {
        set(value, forKey: key.rawValue)
    }
}
