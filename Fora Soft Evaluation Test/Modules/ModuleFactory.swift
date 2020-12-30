//
//  ModuleFactory.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 27.12.2020.
//

import UIKit

final class ModuleFactory {
    
    func makeTabBarModule() -> (view: UITabBarController, moduleInput: TabBarModuleInput) {
        let view = TabBarViewController()
        let presenter = TabBarPresenter()
        view.output = presenter
        presenter.view = view
        presenter.router = TabBarRouter(viewController: view)
        
        return (view, presenter)
    }
    
    func makeSearchModule(viewController: UIViewController, type: SearchModuleType = .default) -> (view: UIViewController, moduleInput: SearchModuleInput) {
        let view = SearchViewController()
        let presenter = SearchPresenter(type: type)
        view.output = presenter
        presenter.view = view
        presenter.router = SearchRouter(viewController: viewController)

        return (view, presenter)
    }
    
    func makeHistoryModule(viewController: UIViewController) -> (view: UIViewController, moduleInput: HistoryModuleInput) {
        let view = HistoryViewController()
        let presenter = HistoryPresenter()
        view.output = presenter
        presenter.view = view
        presenter.router = HistoryRouter(viewController: viewController)

        return (view, presenter)
    }
    
    func makeDetailsModule(viewController: UIViewController, album: Album) -> (view: UIViewController, moduleInput: DetailsModuleInput) {
        let view = DetailsViewController()
        let presenter = DetailsPresenter(album: album)
        view.output = presenter
        presenter.view = view
        presenter.router = DetailsRouter(viewController: viewController)

        return (view, presenter)
    }
}
