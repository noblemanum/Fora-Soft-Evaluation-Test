//
//  HistoryRouter.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 27.12.2020.
//

import Foundation

protocol HistoryRouterInput: AnyObject {
    func showSearchResult(_ query: String)
}

final class HistoryRouter: Router, HistoryRouterInput {
    
    func showSearchResult(_ query: String) {
        let factory = ModuleFactory()
        let (searchView, _) = factory.makeSearchModule(viewController: viewController, type: .query(query))
        
        push(viewController: searchView)
    }
}
