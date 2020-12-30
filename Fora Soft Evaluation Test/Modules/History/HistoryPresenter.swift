//
//  HistoryPresenter.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 26.12.2020.
//

import Foundation

protocol HistoryModuleInput: AnyObject {
}

protocol HistoryModuleOutput: AnyObject {
}

final class HistoryPresenter: HistoryModuleInput, HistoryViewOutput {
    
    weak var view: HistoryViewInput!
    var router: HistoryRouter!
    weak var output: HistoryModuleOutput?
    
    // MARK: - HistoryViewOutput
    
    func viewDidLoad() {
        historyService.add(observer: self)
        reloadViewData()
    }
    
    func didTriggerShowSearchResultEvent(_ query: String, in view: HistoryViewController) {
        router.viewController = view
        router.showSearchResult(query)
    }
    
    func didTriggerDeleteHistory() {
        historyService.clearHistory()
    }
    
    // MARK: - Private
    
    private let historyService = SearchHistoryService.shared
    
    private func reloadViewData() {
        view.reload(with: historyService.currentHistory)
    }
}

extension HistoryPresenter: SearchHistoryObserver {
    
    func onSearchHistoryUpdated(_ history: [String]) {
        reloadViewData()
    }
}
