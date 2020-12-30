//
//  SearchHistoryData.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import Foundation

protocol SearchHistoryObserver: AnyObject {
    func onSearchHistoryUpdated(_ history: [String])
}

final class SearchHistoryService {
    
    static let shared = SearchHistoryService()
    
    var currentHistory: [String] {
        let history: [String] = UserDefaults.standard.value(for: .searchHistory) ?? []
        return history.reversed()
    }
    
    func addQuery(_ string: String) {
        var history = UserDefaults.standard.value(for: .searchHistory) ?? [String]()
        history = history.filter { $0 != string }
        history.append(string)
        history = Array(history.suffix(20))
        UserDefaults.standard.set(history, for: .searchHistory)
        
        observers.invoke { $0.onSearchHistoryUpdated(currentHistory) }
    }
    
    func clearHistory() {
        UserDefaults.standard.set(nil, for: .searchHistory)
        observers.invoke { $0.onSearchHistoryUpdated(currentHistory) }
    }
    
    func add(observer: SearchHistoryObserver) {
        observers.add(observer: observer)
    }
    
    func remove(observer: SearchHistoryObserver) {
        observers.remove(observer: observer)
    }
    
    private let observers = ObserversArray<SearchHistoryObserver>()
}
