//
//  AppDelegate.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 25.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    weak var tabBarModuleInput: TabBarModuleInput?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let factory = ModuleFactory()
        let (view, tabBarModuleInput) = factory.makeTabBarModule()
        
        let searchNavController = UINavigationController()
        let (searchView, _) = factory.makeSearchModule(viewController: searchNavController)
        searchNavController.pushViewController(searchView, animated: false)
        searchView.title = Strings.Search.title.rawValue
        searchView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let historyNavController = UINavigationController()
        let (historyView, _) = factory.makeHistoryModule(viewController: historyNavController)
        historyNavController.pushViewController(historyView, animated: false)
        historyView.title = Strings.History.title.rawValue
        historyView.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        view.setViewControllers([searchNavController, historyNavController], animated: false)
        
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        
        self.tabBarModuleInput = tabBarModuleInput
        
        return true
    }
}
