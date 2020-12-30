//
//  Router.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 27.12.2020.
//

import UIKit

class Router {
    
    weak var viewController: UIViewController!

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func present(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        self.viewController.present(viewController, animated: animated, completion: completion)
    }

    func push(viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    private var navigationController: UINavigationController? {
        return (viewController as? UINavigationController) ?? viewController.navigationController
    }
}
