//
//  TabBarViewController.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 27.12.2020.
//

import UIKit

protocol TabBarViewInput: AnyObject {
}

protocol TabBarViewOutput: AnyObject {
}

final class TabBarViewController: UITabBarController, TabBarViewInput {
    
    var output: TabBarViewOutput!
}
