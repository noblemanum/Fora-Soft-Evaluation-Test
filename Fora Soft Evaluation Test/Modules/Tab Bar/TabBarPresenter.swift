//
//  TabBarPresenter.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 27.12.2020.
//

import Foundation

protocol TabBarModuleInput: AnyObject {
}

protocol TabBarModuleOutput: AnyObject {
}

final class TabBarPresenter: TabBarModuleInput, TabBarViewOutput {
    
    weak var view: TabBarViewInput!
    var router: TabBarRouter!
    weak var output: TabBarModuleOutput?
    
}
